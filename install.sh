#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="/usr/local/bin"
TARGET_BIN="${TARGET_DIR}/vsec"
RAW_URL="https://raw.githubusercontent.com/notasandworm/vsec/main/vsec"

echo "==> Installing vsec (Server Security Dashboard & Monitoring CLI)..."

# Require sudo/root privileges for installing to /usr/local/bin
if [ "$EUID" -ne 0 ]; then
    echo "🔑 Sudo privileges required to install to ${TARGET_DIR}."
    SUDO="sudo"
else
    SUDO=""
fi

$SUDO mkdir -p "$TARGET_DIR"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL_VSEC="${SCRIPT_DIR}/vsec"

if [ -f "$LOCAL_VSEC" ]; then
    echo "==> Installing vsec from local repository..."
    $SUDO cp "$LOCAL_VSEC" "$TARGET_BIN"
else
    echo "==> Downloading vsec from GitHub..."
    if command -v curl &>/dev/null; then
        $SUDO curl -fsSL "$RAW_URL" -o "$TARGET_BIN"
    elif command -v wget &>/dev/null; then
        $SUDO wget -q "$RAW_URL" -O "$TARGET_BIN"
    else
        echo "❌ Error: Neither curl nor wget is available to download vsec."
        exit 1
    fi
fi

$SUDO chmod 755 "$TARGET_BIN"

echo ""
echo "=========================================="
echo "==> vsec Installation Complete"
echo "=========================================="
echo "Binary Installed: ${TARGET_BIN}"
echo ""
echo "Usage Instructions:"
echo "  * vsec requires root/sudo privileges for journald and socket access."
echo "  * Run the security dashboard:"
echo "      sudo vsec"
echo "  * Generate structured JSON output:"
echo "      sudo vsec --json"
