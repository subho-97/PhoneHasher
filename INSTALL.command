#!/bin/bash

# PhoneHasher - Automatic Installer
# Removes quarantine attributes and opens the app

echo "================================================"
echo "PhoneHasher - Automatic Installer"
echo "================================================"
echo ""

# Function to find the app
find_app() {
    # Try common locations
    LOCATIONS=(
        "$HOME/Downloads/PhoneHasher.app"
        "$(dirname "$0")/PhoneHasher.app"
        "$PWD/PhoneHasher.app"
    )

    for loc in "${LOCATIONS[@]}"; do
        if [ -d "$loc" ]; then
            echo "$loc"
            return 0
        fi
    done

    return 1
}

# Find the app
APP_PATH=$(find_app)

if [ -z "$APP_PATH" ]; then
    echo "❌ Could not find PhoneHasher.app"
    echo ""
    echo "Please make sure PhoneHasher.app is in the same folder as this script"
    echo "or in your Downloads folder."
    echo ""
    read -p "Press Enter to exit..."
    exit 1
fi

echo "✓ Found app at: $APP_PATH"
echo ""

# Remove quarantine
echo "Removing security blocks..."
xattr -cr "$APP_PATH"

if [ $? -eq 0 ]; then
    echo "✓ Security blocks removed"
    echo ""
    echo "Opening PhoneHasher..."
    open "$APP_PATH"
    echo ""
    echo "✅ Done! PhoneHasher should open now."
else
    echo "❌ Could not remove security blocks"
    echo ""
    echo "Please try manually:"
    echo "1. Right-click PhoneHasher.app"
    echo "2. Click 'Open'"
    echo "3. Click 'Open' again in the dialog"
fi

echo ""
read -p "Press Enter to close..."
