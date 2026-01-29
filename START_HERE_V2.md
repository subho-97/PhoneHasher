# PhoneHasher Swift v2 - Start Here

**Version 2.0** - Improved UI with cleaner design

---

## 🎉 What's New in v2?

### 1. Toggle switches on the LEFT
- More intuitive layout
- Standard UI pattern
- Easier to read

### 2. Clickable grey boxes
- Click "No files selected" box to browse files
- Click "No folder selected" box to choose folder
- No separate browse buttons needed!
- Much cleaner interface

**See `CHANGES_V2.md` for detailed changes**

---

## 🚀 Quick Start

### Option 1: Build Using GitHub (No Xcode Needed!)

1. **Upload to GitHub**
   - Create repository at github.com
   - Upload all files from this folder
   - See: `GITHUB_WEBSITE_BUILD.md` for step-by-step

2. **Build Automatically**
   - GitHub builds the app for you
   - Wait 2-3 minutes
   - Download from Actions → Artifacts

3. **Install**
   - Unzip PhoneHasher-Swift.zip
   - Double-click `INSTALL.command`
   - Done!

**📖 Full Guide:** `GITHUB_QUICK_CHECKLIST.md`

---

### Option 2: Build Locally (Requires Xcode)

1. **Install Xcode from App Store** (one-time)

2. **Build**
   ```bash
   cd /Users/subhadip.sinha/Downloads/PhoneHasher-Final/final_swift_v2
   ./build_from_cli.sh
   ```

3. **Run**
   ```bash
   open dist/PhoneHasher.app
   ```

**📖 Full Guide:** `CLI_BUILD_GUIDE.md`

---

## 📦 What's Included

### Core Files (Required)
- ✅ `PhoneHasherApp.swift` - Main app entry point
- ✅ `ContentView.swift` - UI (v2 improvements!)
- ✅ `Models.swift` - Data models
- ✅ `HashProcessor.swift` - Hashing logic
- ✅ `Info.plist` - App metadata

### Build Files
- ✅ `build_from_cli.sh` - Command-line build script
- ✅ `INSTALL.command` - Auto-installer (removes security warnings)
- ✅ `.github/workflows/build.yml` - GitHub Actions config

### Documentation
- ✅ `START_HERE_V2.md` - This file
- ✅ `CHANGES_V2.md` - What's new in v2
- ✅ `GITHUB_WEBSITE_BUILD.md` - Build on GitHub website
- ✅ `INSTALLATION_GUIDE.md` - How to install
- ✅ `FIX_DAMAGED_APP.md` - Fix security warnings
- ✅ And more...

---

## 🎯 Recommended Path

**For most users:** **GitHub Actions** (easiest!)
1. Read `GITHUB_QUICK_CHECKLIST.md`
2. Upload files to GitHub
3. Download built app
4. Double-click `INSTALL.command`

**For developers:** **Local Build**
1. Install Xcode once
2. Run `./build_from_cli.sh`
3. Test immediately

---

## ✨ UI Improvements Preview

### Toggle Layout (NEW!)
```
Before v2:                       After v2 (Better!):
━━━━━━━━━━━━━━━━━━━━━━━         ━━━━━━━━━━━━━━━━━━━━━━━
Hash for 3P Platforms    [ON]   [ON]  Hash for 3P Platforms
e.g., 9876543210                      e.g., 9876543210
```

### File Selection (NEW!)
```
Before v2:                       After v2 (Better!):
━━━━━━━━━━━━━━━━━━━━━━━         ━━━━━━━━━━━━━━━━━━━━━━━
┌───────────────────┐            ┌───────────────────┐
│  📁               │            │  📁               │
│  No files selected│            │  No files selected│ ← Click me!
└───────────────────┘            │ (Click to browse) │
                                 └───────────────────┘
[Browse Files] button            (No button needed!)
```

**Result:** Cleaner, more intuitive interface! 🎨

---

## 📋 Building Checklist

### GitHub Method
- [ ] Read `GITHUB_QUICK_CHECKLIST.md`
- [ ] Create GitHub repository
- [ ] Upload all files from `final_swift_v2/`
- [ ] Wait for build to complete
- [ ] Download from Artifacts
- [ ] Run `xattr -cr PhoneHasher.app` OR double-click `INSTALL.command`

### Local Method
- [ ] Install Xcode.app
- [ ] Run `./build_from_cli.sh`
- [ ] Test `dist/PhoneHasher.app`
- [ ] Distribute to team

---

## 🔧 Installation (After Building)

When you download the built app:

**EASIEST:**
```
1. Unzip PhoneHasher-Swift.zip
2. Double-click INSTALL.command
3. App opens automatically!
```

**ALTERNATIVE:**
```bash
xattr -cr ~/Downloads/PhoneHasher.app && open ~/Downloads/PhoneHasher.app
```

**See:** `FIX_DAMAGED_APP.md` for why this is needed

---

## 🎓 Documentation Guide

**Just starting?**
→ You're here! (START_HERE_V2.md)

**What changed in v2?**
→ Read `CHANGES_V2.md`

**Want to build without Xcode?**
→ Read `BUILD_WITHOUT_XCODE.md`

**Need quick checklist?**
→ Read `GITHUB_QUICK_CHECKLIST.md`

**Installing the app?**
→ Read `INSTALLATION_GUIDE.md`

**"App is damaged" error?**
→ Read `FIX_DAMAGED_APP.md`

---

## ⚡ Quick Commands

### Build locally
```bash
./build_from_cli.sh
```

### Fix "damaged app" error
```bash
xattr -cr ~/Downloads/PhoneHasher.app && open ~/Downloads/PhoneHasher.app
```

### Test the app
```bash
open dist/PhoneHasher.app
```

---

## 🆚 v1 vs v2 Comparison

| Feature | v1 | v2 |
|---------|-------|-------|
| Toggle Position | Right side | Left side ✨ |
| File Browser | Separate button | Click grey box ✨ |
| Folder Browser | Separate button | Click grey box ✨ |
| UI Cleanliness | Good | Better ✨ |
| Functionality | ✅ | ✅ Same |
| Performance | ✅ | ✅ Same |

**v2 = Same power, better looks!** 🎨

---

## 💡 Pro Tips

1. **Use GitHub Actions**
   - No Xcode installation needed
   - Builds in the cloud
   - 100% free

2. **Use INSTALL.command**
   - Fixes security warnings automatically
   - One double-click
   - Share with team

3. **Test before distributing**
   - Build locally first
   - Verify all features work
   - Then share with team

---

## 🎯 Next Steps

1. **Choose build method:**
   - GitHub Actions (recommended) → `GITHUB_QUICK_CHECKLIST.md`
   - Local build → `CLI_BUILD_GUIDE.md`

2. **Build the app**
   - Follow the chosen guide
   - Wait for build to complete

3. **Test it**
   - Run `INSTALL.command` or `xattr` command
   - Verify UI improvements
   - Test file processing

4. **Share with team**
   - Upload to Google Drive
   - Include `INSTALL.command`
   - Send installation instructions

---

## ✅ Success Indicators

You'll know it's working when:
- ✅ Toggle switches appear on the LEFT
- ✅ Grey boxes say "(Click to browse)"
- ✅ Clicking grey box opens file/folder browser
- ✅ No "Browse Files" or "Select Folder" buttons
- ✅ App processes files correctly

---

## 🆘 Need Help?

**Build issues?**
→ Check `CLI_BUILD_GUIDE.md` troubleshooting

**Installation issues?**
→ Check `FIX_DAMAGED_APP.md`

**GitHub issues?**
→ Check `GITHUB_WEBSITE_BUILD.md`

**General questions?**
→ Check `INSTALLATION_GUIDE.md`

---

## 📞 File Structure

```
final_swift_v2/
├── START_HERE_V2.md              ← You are here!
├── CHANGES_V2.md                 ← What's new
│
├── ContentView.swift             ← UI (v2 improvements!)
├── PhoneHasherApp.swift
├── Models.swift
├── HashProcessor.swift
├── Info.plist
│
├── build_from_cli.sh
├── INSTALL.command
│
├── .github/workflows/build.yml   ← GitHub Actions
│
└── [documentation files]
```

---

## 🎉 Ready to Build!

**Fastest path:**
1. Read `GITHUB_QUICK_CHECKLIST.md` (5 min)
2. Upload to GitHub (3 min)
3. Download built app (2 min)
4. Double-click `INSTALL.command` (10 sec)

**Total time: 10 minutes!** ⏱️

---

**Questions?** Check the documentation files above!

**Ready?** Go to `GITHUB_QUICK_CHECKLIST.md` to start! 🚀
