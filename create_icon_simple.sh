#!/bin/bash

# Simple icon creator for PhoneHasher
# Uses only macOS built-in tools (no Python packages needed)

echo "Creating PhoneHasher app icon..."

# Create a simple SVG icon
cat > icon_temp.svg << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<svg width="1024" height="1024" xmlns="http://www.w3.org/2000/svg">
  <!-- Blue gradient background -->
  <defs>
    <linearGradient id="bgGrad" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#1e3a8a;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#2563eb;stop-opacity:1" />
    </linearGradient>
    <linearGradient id="shieldGrad" x1="0%" y1="0%" x2="0%" y2="100%">
      <stop offset="0%" style="stop-color:#3b82f6;stop-opacity:1" />
      <stop offset="100%" style="stop-color:#2563eb;stop-opacity:1" />
    </linearGradient>
  </defs>

  <!-- Background -->
  <rect width="1024" height="1024" fill="url(#bgGrad)"/>

  <!-- Rounded square -->
  <rect x="180" y="180" width="664" height="664" rx="120"
        fill="#3b82f6" stroke="#ffffff" stroke-width="12"/>

  <!-- Shield shape -->
  <path d="M 512 220 L 280 280 L 280 520 L 512 720 L 744 520 L 744 280 Z"
        fill="#ffffff" opacity="0.95"/>

  <!-- Lock body -->
  <rect x="442" y="460" width="140" height="160" rx="20" fill="#1e3a8a"/>

  <!-- Lock shackle -->
  <path d="M 472 460 Q 472 400 512 400 Q 552 400 552 460"
        fill="none" stroke="#1e3a8a" stroke-width="22" stroke-linecap="round"/>

  <!-- Keyhole -->
  <circle cx="512" cy="510" r="24" fill="#ffffff"/>
  <rect x="504" y="510" width="16" height="40" fill="#ffffff"/>
</svg>
EOF

echo "✓ SVG created"

# Convert SVG to PNG using macOS built-in tool
if command -v qlmanage &> /dev/null; then
    # Use qlmanage to convert (available on macOS)
    qlmanage -t -s 1024 -o . icon_temp.svg 2>/dev/null
    mv icon_temp.svg.png icon_1024.png 2>/dev/null || {
        echo "❌ qlmanage conversion failed, trying sips..."
        # Fallback: create a simple colored PNG
        sips -s format png icon_temp.svg --out icon_1024.png 2>/dev/null || {
            echo "⚠️  Cannot create icon without additional tools"
            echo ""
            echo "OPTIONS:"
            echo "1. Skip icon generation for now (GitHub Actions will handle it)"
            echo "2. Install Pillow: python3 -m pip install Pillow --break-system-packages --user"
            echo "3. Use brew: brew install pillow (then pip install Pillow)"
            rm -f icon_temp.svg
            exit 1
        }
    }
else
    echo "❌ qlmanage not found"
    rm -f icon_temp.svg
    exit 1
fi

# Create iconset directory
mkdir -p AppIcon.iconset

# Generate all required sizes using sips
echo "Generating icon sizes..."
sizes=(16 32 64 128 256 512 1024)
for size in "${sizes[@]}"; do
    sips -z $size $size icon_1024.png --out "AppIcon.iconset/icon_${size}x${size}.png" &>/dev/null

    # Create @2x versions for smaller sizes
    if [ $size -le 512 ]; then
        double=$((size * 2))
        sips -z $double $double icon_1024.png --out "AppIcon.iconset/icon_${size}x${size}@2x.png" &>/dev/null
    fi
done

echo "✓ Icon sizes generated"

# Convert to icns
iconutil -c icns AppIcon.iconset -o AppIcon.icns

if [ -f "AppIcon.icns" ]; then
    echo "✓ AppIcon.icns created successfully!"

    # Cleanup
    rm -rf AppIcon.iconset
    rm -f icon_temp.svg icon_1024.png

    ls -lh AppIcon.icns
    echo ""
    echo "✅ Done! AppIcon.icns is ready."
else
    echo "❌ Failed to create AppIcon.icns"
    exit 1
fi
