#!/bin/bash

# This script merges the settings.json from this repository into the global
# ~/.gemini/settings.json file.

# It uses jq to intelligently merge the JSON files, so make sure jq is installed.
# On macOS: brew install jq

# --- Paths ---
LOCAL_SETTINGS="./settings.json"
GLOBAL_SETTINGS_DIR="$HOME/.gemini"
GLOBAL_SETTINGS_FILE="$GLOBAL_SETTINGS_DIR/settings.json"

# --- Pre-flight Checks ---
# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Please install it to continue."
    echo "On macOS, run: brew install jq"
    exit 1
fi

# Check if the local settings file exists
if [ ! -f "$LOCAL_SETTINGS" ]; then
    echo "Error: Local settings file not found at $LOCAL_SETTINGS"
    exit 1
fi

# --- Merge Logic ---
# Ensure the global settings directory exists
if [ ! -d "$GLOBAL_SETTINGS_DIR" ]; then
    echo "Global settings directory not found. Creating it at $GLOBAL_SETTINGS_DIR"
    mkdir -p "$GLOBAL_SETTINGS_DIR"
fi

# If the global settings file doesn't exist, just copy the local one
if [ ! -f "$GLOBAL_SETTINGS_FILE" ]; then
    echo "Global settings file not found. Copying local settings to $GLOBAL_SETTINGS_FILE"
    cp "$LOCAL_SETTINGS" "$GLOBAL_SETTINGS_FILE"
else
    # If it exists, merge them
    echo "Global settings file found. Merging local settings into it..."
    # Create a backup
    cp "$GLOBAL_SETTINGS_FILE" "${GLOBAL_SETTINGS_FILE}.bak"
    echo "Backup of original settings saved to ${GLOBAL_SETTINGS_FILE}.bak"

    # Merge the files using jq. The `*` operator recursively merges.
    # The local file takes precedence.
    jq -s '.[0] * .[1]' "$GLOBAL_SETTINGS_FILE" "$LOCAL_SETTINGS" > "${GLOBAL_SETTINGS_FILE}.tmp" && mv "${GLOBAL_SETTINGS_FILE}.tmp" "$GLOBAL_SETTINGS_FILE"
fi

echo "Settings successfully applied."

# --- Sync GEMINI.md ---
echo "Syncing GEMINI.md..."
cp "./GEMINI.md" "$GLOBAL_SETTINGS_DIR/GEMINI.md"

# --- Sync rules Directory ---
echo "Syncing rules directory..."
rsync -av --delete "./rules/" "$GLOBAL_SETTINGS_DIR/rules/"

# --- Sync commands Directory ---
echo "Syncing commands directory..."
rsync -av --delete "./commands/" "$GLOBAL_SETTINGS_DIR/commands/"

echo "GEMINI.md, rules, and commands directories successfully synced."
