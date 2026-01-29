#!/usr/bin/env python3
"""
Create a simple app icon for PhoneHasher
"""
from PIL import Image, ImageDraw
import os

# Create a 1024x1024 image with gradient background
size = 1024
img = Image.new('RGB', (size, size), color='white')
draw = ImageDraw.Draw(img)

# Create gradient background (blue)
for y in range(size):
    # Gradient from #1e3a8a to #2563eb
    r1, g1, b1 = 30, 58, 138
    r2, g2, b2 = 37, 99, 235

    ratio = y / size
    r = int(r1 + (r2 - r1) * ratio)
    g = int(g1 + (g2 - g1) * ratio)
    b = int(b1 + (b2 - b1) * ratio)

    draw.rectangle([(0, y), (size, y+1)], fill=(r, g, b))

# Draw a rounded square in the center (lighter blue)
margin = 180
rect_size = size - (margin * 2)
corner_radius = 120

# Draw rounded rectangle
draw.rounded_rectangle(
    [(margin, margin), (size - margin, size - margin)],
    radius=corner_radius,
    fill=(59, 130, 246),
    outline=(255, 255, 255),
    width=12
)

# Draw shield shape (simplified)
shield_margin = 280
shield_width = size - (shield_margin * 2)
shield_height = shield_width * 1.2
shield_top = (size - shield_height) // 2

# Shield points (simplified shield shape)
shield_points = [
    (size // 2, shield_top),  # Top center
    (shield_margin, shield_top + 80),  # Top left
    (shield_margin, shield_top + shield_height * 0.6),  # Middle left
    (size // 2, shield_top + shield_height),  # Bottom point
    (size - shield_margin, shield_top + shield_height * 0.6),  # Middle right
    (size - shield_margin, shield_top + 80),  # Top right
]

draw.polygon(shield_points, fill=(255, 255, 255, 220))

# Draw lock icon simplified
lock_center_x = size // 2
lock_center_y = shield_top + shield_height // 2 + 30
lock_width = 140
lock_height = 160

# Lock body (rectangle)
lock_body_top = lock_center_y - 20
draw.rounded_rectangle(
    [
        (lock_center_x - lock_width // 2, lock_body_top),
        (lock_center_x + lock_width // 2, lock_body_top + lock_height)
    ],
    radius=20,
    fill=(30, 58, 138)
)

# Lock shackle (arc)
shackle_width = lock_width - 40
shackle_height = 100
draw.arc(
    [
        (lock_center_x - shackle_width // 2, lock_body_top - shackle_height + 20),
        (lock_center_x + shackle_width // 2, lock_body_top + 20)
    ],
    start=180,
    end=0,
    fill=(30, 58, 138),
    width=22
)

# Draw keyhole
keyhole_circle_radius = 24
keyhole_y = lock_center_y + 10
draw.ellipse(
    [
        (lock_center_x - keyhole_circle_radius, keyhole_y - keyhole_circle_radius),
        (lock_center_x + keyhole_circle_radius, keyhole_y + keyhole_circle_radius)
    ],
    fill=(255, 255, 255)
)

# Keyhole slot
keyhole_slot_width = 16
keyhole_slot_height = 40
draw.rectangle(
    [
        (lock_center_x - keyhole_slot_width // 2, keyhole_y),
        (lock_center_x + keyhole_slot_width // 2, keyhole_y + keyhole_slot_height)
    ],
    fill=(255, 255, 255)
)

# Save the icon
output_path = 'AppIcon.png'
img.save(output_path, 'PNG')
print(f"Icon created: {output_path}")
print("Now converting to .icns format...")

# Convert to .icns using sips
os.system(f'mkdir -p AppIcon.iconset')

# Create different sizes for iconset
sizes = [16, 32, 64, 128, 256, 512, 1024]
for s in sizes:
    img_resized = img.resize((s, s), Image.LANCZOS)
    img_resized.save(f'AppIcon.iconset/icon_{s}x{s}.png')
    if s <= 512:
        img_resized_2x = img.resize((s*2, s*2), Image.LANCZOS)
        img_resized_2x.save(f'AppIcon.iconset/icon_{s}x{s}@2x.png')

# Convert iconset to icns
os.system('iconutil -c icns AppIcon.iconset -o AppIcon.icns')
os.system('rm -rf AppIcon.iconset')
os.system('rm AppIcon.png')

print("✅ AppIcon.icns created successfully!")
