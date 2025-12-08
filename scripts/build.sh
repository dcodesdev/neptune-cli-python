#!/usr/bin/env bash
#
# Build script for Neptune CLI (Linux/macOS)
# Creates a single-file executable using PyInstaller
#

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

cd "$PROJECT_ROOT"

echo "==> Syncing dependencies..."
uv sync --group dev

echo "==> Building Neptune CLI with PyInstaller..."
uv run pyinstaller neptune.spec --clean --noconfirm

echo "==> Build complete!"
echo "    Executable: $PROJECT_ROOT/dist/neptune"

# Verify the build
if [[ -f "$PROJECT_ROOT/dist/neptune" ]]; then
    echo "==> Verifying build..."
    "$PROJECT_ROOT/dist/neptune" --help
else
    echo "ERROR: Build failed - executable not found"
    exit 1
fi
