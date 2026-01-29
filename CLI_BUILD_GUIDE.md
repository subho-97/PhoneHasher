# PhoneHasher Swift - Command Line Build Guide

Build the PhoneHasher Swift app **without opening Xcode**, using command-line tools or GitHub Actions.

---

## 🚀 Quick Start (Local Build)

### Prerequisites
- macOS 10.15 or later
- Xcode Command Line Tools installed

### Check if Command Line Tools are installed
```bash
xcodebuild -version
```

If not installed, run:
```bash
xcode-select --install
```

### Build the App
```bash
cd /Users/subhadip.sinha/Downloads/PhoneHasher-Final/PhoneHasher_Swift
./build_from_cli.sh
```

That's it! The script will:
1. ✅ Create the Xcode project structure
2. ✅ Build the app using `xcodebuild`
3. ✅ Create distribution package in `dist/` folder
4. ✅ Create PhoneHasher-Swift.zip ready to share

### Output
After build completes:
- **App:** `dist/PhoneHasher.app` (~5-8 MB)
- **ZIP:** `dist/PhoneHasher-Swift.zip` (~3-5 MB)
- **README:** `dist/README.txt` (installation instructions)

---

## 🐙 GitHub Actions Build (Automatic)

### Setup (One-time)

1. **Push this folder to GitHub:**
```bash
cd /Users/subhadip.sinha/Downloads/PhoneHasher-Final
git init
git add PhoneHasher_Swift/
git commit -m "Add PhoneHasher Swift app"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/PhoneHasher.git
git push -u origin main
```

2. **GitHub will automatically:**
   - Detect the `.github/workflows/build.yml` file
   - Build the app on every push
   - Store the app as downloadable artifacts

### Triggering a Build

**Automatic triggers:**
- Every push to `main` or `master` branch
- Every pull request

**Manual trigger:**
1. Go to your GitHub repository
2. Click **Actions** tab
3. Click **Build PhoneHasher Swift App** workflow
4. Click **Run workflow** → **Run workflow**

### Downloading the Built App

1. Go to **Actions** tab
2. Click on the latest successful build (green ✓)
3. Scroll to **Artifacts** section
4. Download:
   - `PhoneHasher-Swift` - ZIP file ready to share
   - `PhoneHasher-App` - Just the .app file

---

## 📋 What the Build Script Does

The `build_from_cli.sh` script:

1. **Checks prerequisites**
   - Verifies Xcode command line tools are installed
   - Confirms source files exist

2. **Creates Xcode project structure**
   - Generates `.xcodeproj` file
   - Sets up project configuration
   - Configures Info.plist

3. **Builds the app**
   - Uses `xcodebuild` to compile Swift code
   - Creates optimized Release build
   - Signs to run locally (no Apple Developer account needed)

4. **Creates distribution package**
   - Copies built app to `dist/` folder
   - Removes quarantine attributes
   - Creates README with installation instructions
   - Packages everything into a ZIP file

5. **Cleans up**
   - Removes intermediate build files
   - Keeps only the final app and ZIP

---

## 🛠️ Build Configuration

### Default Settings
- **Deployment Target:** macOS 13.0+
- **Architecture:** Native (auto-detects your Mac)
- **Optimization:** Release (optimized, smaller size)
- **Code Signing:** Local signing (no Developer ID)

### Customize Build

Edit the script variables:
```bash
APP_NAME="PhoneHasher"           # Change app name
BUNDLE_ID="com.phonehash.app"   # Change bundle ID
```

### Build for Universal Binary (Intel + Apple Silicon)

Replace the `xcodebuild` command in the script with:
```bash
xcodebuild \
    -project "$PROJECT_DIR/$APP_NAME.xcodeproj" \
    -scheme "$APP_NAME" \
    -configuration Release \
    -derivedDataPath "$DERIVED_DATA" \
    -arch x86_64 -arch arm64 \
    CODE_SIGN_IDENTITY="-" \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGNING_ALLOWED=NO \
    build
```

---

## 🧪 Testing the Built App

### Run locally
```bash
open dist/PhoneHasher.app
```

### Verify app info
```bash
# Check file size
du -sh dist/PhoneHasher.app

# Check code signature
codesign -dv dist/PhoneHasher.app

# Check architecture
lipo -info dist/PhoneHasher.app/Contents/MacOS/PhoneHasher
```

---

## 📦 Distribution

### Option 1: Share ZIP file
Upload `dist/PhoneHasher-Swift.zip` to:
- Google Drive
- Dropbox
- GitHub Releases
- WeTransfer

Users will need to:
1. Download and unzip
2. Right-click app → Open
3. Click "Open" in security dialog

### Option 2: GitHub Releases
```bash
# Tag a release
git tag v1.0.0
git push origin v1.0.0

# Upload dist/PhoneHasher-Swift.zip as release asset
```

### Option 3: AirDrop
- AirDrop `dist/PhoneHasher.app` directly
- No security warnings for recipients!

---

## 🔧 Troubleshooting

### "xcodebuild: command not found"
**Solution:**
```bash
xcode-select --install
```

### "No such file or directory: PhoneHasherApp.swift"
**Solution:** Make sure you're in the PhoneHasher_Swift directory:
```bash
cd /Users/subhadip.sinha/Downloads/PhoneHasher-Final/PhoneHasher_Swift
```

### Build fails with "CryptoKit not found"
**Solution:** Check macOS version (requires 13.0+):
```bash
sw_vers
```

### "Permission denied" when running script
**Solution:**
```bash
chmod +x build_from_cli.sh
```

### GitHub Actions build fails
**Common causes:**
1. Workflow file not in `.github/workflows/` folder
2. Source files not committed to repository
3. Syntax error in YAML file

**Check workflow:**
```bash
# Validate YAML syntax
cat .github/workflows/build.yml
```

---

## 📊 Comparison: Local vs GitHub

| Aspect | Local Build | GitHub Actions |
|--------|-------------|----------------|
| **Setup** | Install Xcode CLI tools | Push to GitHub |
| **Speed** | 30-60 seconds | 2-3 minutes |
| **Automation** | Manual | Automatic on push |
| **Cost** | Free | Free (2000 min/month) |
| **Internet** | Not required | Required |
| **Flexibility** | Full control | CI/CD integration |

---

## 🎯 CI/CD Integration

### Add to existing workflow
```yaml
- name: Build macOS app
  run: |
    cd PhoneHasher_Swift
    ./build_from_cli.sh
```

### Auto-release on tag
Add to `.github/workflows/build.yml`:
```yaml
- name: Create Release
  if: startsWith(github.ref, 'refs/tags/')
  uses: softprops/action-gh-release@v1
  with:
    files: PhoneHasher_Swift/dist/PhoneHasher-Swift.zip
```

---

## 📝 Files Created

### Generated by script
- `PhoneHasher.xcodeproj/` - Xcode project structure
- `PhoneHasher/` - Source files organized for Xcode
- `DerivedData/` - Build artifacts (can be deleted)
- `dist/PhoneHasher.app` - Final application
- `dist/PhoneHasher-Swift.zip` - Distribution package
- `dist/README.txt` - Installation instructions

### Cleanup after build
```bash
# Keep only distribution files
rm -rf DerivedData/
rm -rf PhoneHasher.xcodeproj/
rm -rf PhoneHasher/

# Now only dist/ folder remains
```

---

## 🚀 Advanced Usage

### Build multiple configurations
```bash
# Debug build
xcodebuild -configuration Debug ...

# Release build (default)
xcodebuild -configuration Release ...
```

### Custom output directory
```bash
# Edit script
DIST_DIR="/path/to/custom/output"
```

### Parallel builds
```bash
# Build faster with multiple cores
xcodebuild -parallelizeTargets ...
```

---

## 💡 Why Use Command Line?

### Advantages
✅ **Automation** - Script builds, no clicking
✅ **CI/CD** - Integrate with GitHub Actions
✅ **Reproducible** - Same build every time
✅ **Fast** - No Xcode GUI overhead
✅ **Scriptable** - Chain with other commands
✅ **Remote** - Build on servers

### When to use Xcode GUI
❌ Visual design/debugging
❌ Storyboard editing
❌ First-time setup
❌ Learning Swift

---

## 🎓 How It Works

### Step-by-step breakdown

1. **Project file generation**
   - Script creates `.xcodeproj` with project structure
   - Defines targets, build phases, settings
   - Uses Xcode's pbxproj format

2. **xcodebuild compilation**
   - Compiles Swift files to machine code
   - Links frameworks (SwiftUI, CryptoKit)
   - Bundles into .app package

3. **Packaging**
   - Copies resources (Info.plist)
   - Sets permissions
   - Creates distributable package

---

## 📚 Resources

- [xcodebuild man page](https://developer.apple.com/library/archive/technotes/tn2339/)
- [GitHub Actions macOS runners](https://docs.github.com/en/actions/using-github-hosted-runners/about-github-hosted-runners)
- [Code signing guide](https://developer.apple.com/support/code-signing/)

---

## 🤝 Contributing

To build and test changes:
```bash
# Make changes to Swift files
vim ContentView.swift

# Rebuild
./build_from_cli.sh

# Test
open dist/PhoneHasher.app
```

---

## ⚡ Quick Reference

```bash
# Build app
./build_from_cli.sh

# Test app
open dist/PhoneHasher.app

# Clean build
rm -rf DerivedData/ PhoneHasher.xcodeproj/ PhoneHasher/

# Create GitHub release
git tag v1.0.0 && git push origin v1.0.0
```

---

**Questions?** Check BUILD_INSTRUCTIONS.md or open an issue on GitHub.

**Ready to build!** Run `./build_from_cli.sh` and you're done! 🎉
