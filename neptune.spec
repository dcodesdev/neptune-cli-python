# -*- mode: python ; coding: utf-8 -*-
"""PyInstaller spec file for Neptune CLI."""

from PyInstaller.utils.hooks import collect_all, collect_submodules

block_cipher = None

# Collect all data and submodules for packages with dynamic imports
datas = []
binaries = []
hiddenimports = []

# Packages that need full collection due to dynamic imports
packages_to_collect = [
    'pydantic',
    'pydantic_settings',
    'pydantic_core',
    'fastmcp',
    'neptune_common',
    'loguru',
    'click',
    'platformdirs',
    'requests',
    'certifi',
    'anyio',
    'starlette',
    'uvicorn',
    'httpx',
    'httpcore',
    'sse_starlette',
    'mcp',
]

for package in packages_to_collect:
    try:
        pkg_datas, pkg_binaries, pkg_hiddenimports = collect_all(package)
        datas += pkg_datas
        binaries += pkg_binaries
        hiddenimports += pkg_hiddenimports
    except Exception:
        pass

# Add the mcp_instructions.md data file
datas += [('src/neptune_cli/mcp_instructions.md', 'neptune_cli')]

# Additional hidden imports for stdlib modules used dynamically
hiddenimports += [
    'webbrowser',
    'subprocess',
    'urllib.parse',
    'http.server',
    'json',
    'typing_extensions',
    'annotated_types',
    'email.mime.text',
]

a = Analysis(
    ['src/neptune_cli/cli.py'],
    pathex=['src'],
    binaries=binaries,
    datas=datas,
    hiddenimports=hiddenimports,
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    win_no_prefer_redirects=False,
    win_private_assemblies=False,
    cipher=block_cipher,
    noarchive=False,
)

pyz = PYZ(a.pure, a.zipped_data, cipher=block_cipher)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.zipfiles,
    a.datas,
    [],
    name='neptune',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=True,
    upx_exclude=[],
    runtime_tmpdir=None,
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
)
