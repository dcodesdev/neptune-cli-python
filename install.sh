#!/usr/bin/env bash
set -e

REPO="dcodesdev/neptune-cli-python"
INSTALL_DIR="${INSTALL_DIR:-/usr/local/bin}"
BINARY_NAME="neptune"

# Detect OS and architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
    Linux*)  OS="linux" ;;
    Darwin*) OS="macos" ;;
    MINGW*|MSYS*|CYGWIN*) OS="windows" ;;
    *) echo "Unsupported OS: $OS"; exit 1 ;;
esac

case "$ARCH" in
    x86_64|amd64) ARCH="amd64" ;;
    arm64|aarch64) ARCH="arm64" ;;
    *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
esac

# Windows only supports amd64
if [[ "$OS" == "windows" && "$ARCH" != "amd64" ]]; then
    echo "Windows ARM64 is not supported"
    exit 1
fi

# Build asset name
if [[ "$OS" == "windows" ]]; then
    ASSET_NAME="neptune-${OS}-${ARCH}.exe"
    BINARY_NAME="neptune.exe"
else
    ASSET_NAME="neptune-${OS}-${ARCH}"
fi

echo "Detected: $OS $ARCH"
echo "Downloading: $ASSET_NAME"

# Get latest release URL
LATEST_URL="https://github.com/${REPO}/releases/latest/download/${ASSET_NAME}"

# Create temp directory
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

# Download binary
curl -fsSL "$LATEST_URL" -o "$TMP_DIR/$BINARY_NAME"
chmod +x "$TMP_DIR/$BINARY_NAME"

# Install
if [[ -w "$INSTALL_DIR" ]]; then
    mv "$TMP_DIR/$BINARY_NAME" "$INSTALL_DIR/$BINARY_NAME"
else
    echo "Installing to $INSTALL_DIR (requires sudo)"
    sudo mv "$TMP_DIR/$BINARY_NAME" "$INSTALL_DIR/$BINARY_NAME"
fi

echo "Neptune CLI installed to $INSTALL_DIR/$BINARY_NAME"
echo "Run 'neptune --help' to get started"
