#!/usr/bin/env nix-shell
#!nix-shell -i bash -p git

set -euo pipefail

# --- Configuration ---
# Source directory for the new NixOS config, relative to this script's location
SOURCE_DIR="$(dirname "${BASH_SOURCE[0]}")/gemini-riced-config"
# Destination for the NixOS config
TARGET_DIR="/etc/nixos"
# --- 

echo "--- Ensuring flakes are enabled in the current system ---"

# Find the latest backup directory (where the original configuration.nix is)
LATEST_BACKUP_DIR=$(ls -td /etc/nixos.bak.* 2>/dev/null | head -1)

if [[ -d "$LATEST_BACKUP_DIR" ]]; then
    ORIGINAL_CONFIG_PATH="$LATEST_BACKUP_DIR/configuration.nix"
    if [[ -f "$ORIGINAL_CONFIG_PATH" ]]; then
        echo ">>> Found original configuration at $ORIGINAL_CONFIG_PATH"

        # Check if experimental features are already set
        if ! grep -q "nix.settings.experimental-features" "$ORIGINAL_CONFIG_PATH"; then
            echo ">>> Adding experimental features to original configuration..."
            echo -e "\n  nix.settings.experimental-features = [ \"nix-command\" \"flakes\" ];" | tee -a "$ORIGINAL_CONFIG_PATH" > /dev/null
        else
            echo ">>> 'nix.settings.experimental-features' already present. Assuming 'nix-command' and 'flakes' are included."
        fi

        echo ">>> Rebuilding system with flakes enabled (using original config)..."
        if ! nixos-rebuild switch -I nixos-config="$ORIGINAL_CONFIG_PATH"; then
            echo "❌ Failed to enable flakes in original configuration. Please enable them manually."
            exit 1
        fi
        echo "✅ Flakes enabled in current system."
    else
        echo "Warning: Original configuration.nix not found in backup. Skipping flake enablement."
    fi
else
    echo "Warning: No backup of original /etc/nixos found. Assuming flakes are already enabled or this is a fresh install."
fi

echo "--- Proceeding with new configuration ---"

# Check if running as root
if [[ "$EUID" -ne 0 ]]; then
    echo "This script must be run with sudo or as root."
    exit 1
fi


# Check if source directory exists
if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Source directory not found at $SOURCE_DIR"
    echo "Please make sure 'gemini-riced-config' directory exists in the same location as this script."
    exit 1
fi

echo "--- NixOS Configuration Installer ---"

# 1. Backup existing configuration
if [[ -d "$TARGET_DIR" ]]; then
    BACKUP_DIR="${TARGET_DIR}.bak.$(date +%Y%m%d-%H%M%S)"
    echo ">>> Backing up current configuration from $TARGET_DIR to $BACKUP_DIR..."
    mv "$TARGET_DIR" "$BACKUP_DIR"
else
    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$TARGET_DIR")"
fi

# 2. Copy new configuration
echo ">>> Copying new configuration to $TARGET_DIR..."
cp -r "$SOURCE_DIR" "$TARGET_DIR"

# 3. Rebuild the system
echo ">>> Rebuilding NixOS system... This may take a while."

# The flake identifier should match the output in your flake.nix
FLAKE_IDENTIFIER="nixos"

if nixos-rebuild switch --flake "$TARGET_DIR#$FLAKE_IDENTIFIER"; then
    echo "✅ System successfully rebuilt!"
    echo "Please set your password with 'passwd maurux01' and then reboot to enjoy your new desktop."
else
    echo "❌ Build failed."
    echo "Your system has not been changed. You can reboot to access the previous working generation."
    echo "The failed configuration is in $TARGET_DIR and the backup of your old one is in $BACKUP_DIR (if it existed)."
    exit 1
fi

exit 0
