#!/bin/bash

# PhoneHasher Auto-Installer
# Double-click this file to install PhoneHasher without terminal commands!

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo ""
echo "=========================================="
echo "   PhoneHasher - Auto Installer"
echo "=========================================="
echo ""

# Find PhoneHasher.app in the same directory
APP_PATH="$SCRIPT_DIR/PhoneHasher.app"

if [ ! -d "$APP_PATH" ]; then
    echo "❌ ERROR: PhoneHasher.app not found in the same folder"
    echo ""
    echo "Make sure PhoneHasher.app is in the same folder as this installer."
    echo ""
    read -p "Press Enter to exit..."
    exit 1
fi

echo -e "${BLUE}Found: PhoneHasher.app${NC}"
echo ""

echo -e "${BLUE}Step 1: Removing security quarantine...${NC}"
xattr -cr "$APP_PATH"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Quarantine removed${NC}"
else
    echo -e "${YELLOW}⚠️  Could not remove quarantine (might need admin password)${NC}"
    echo "Trying with sudo..."
    sudo xattr -cr "$APP_PATH"
fi

echo ""
echo -e "${BLUE}Step 2: Opening PhoneHasher...${NC}"
open "$APP_PATH"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ PhoneHasher opened successfully!${NC}"
    echo ""
    echo "=========================================="
    echo "   Installation Complete! 🎉"
    echo "=========================================="
    echo ""
    echo "PhoneHasher is now running."
    echo "You can close this window."
    echo ""
else
    echo -e "${YELLOW}⚠️  Could not open automatically${NC}"
    echo ""
    echo "Please try:"
    echo "1. Right-click PhoneHasher.app"
    echo "2. Click 'Open'"
    echo "3. Click 'Open' again in the dialog"
    echo ""
fi

# Keep window open for 3 seconds so user can see the result
sleep 3
