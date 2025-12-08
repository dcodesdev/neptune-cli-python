#
# Build script for Neptune CLI (Windows)
# Creates a single-file executable using PyInstaller
#

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = Split-Path -Parent $ScriptDir

Set-Location $ProjectRoot

Write-Host "==> Syncing dependencies..."
uv sync --group dev

Write-Host "==> Building Neptune CLI with PyInstaller..."
uv run pyinstaller neptune.spec --clean --noconfirm

Write-Host "==> Build complete!"
Write-Host "    Executable: $ProjectRoot\dist\neptune.exe"

# Verify the build
$ExePath = Join-Path $ProjectRoot "dist\neptune.exe"
if (Test-Path $ExePath) {
    Write-Host "==> Verifying build..."
    & $ExePath --help
} else {
    Write-Host "ERROR: Build failed - executable not found"
    exit 1
}
