# PhoneHasher v2 - Quick Reference Card

Everything you need to know on one page.

---

## 🎯 What Changed in v2

✅ **Toggle switches on LEFT** (was on right)
✅ **Clickable grey boxes** (no separate browse buttons)
✅ **Clear button** (appears after selecting files)
✅ **Cleaner UI** (fewer buttons, more intuitive)

---

## 🚀 Build Commands

### GitHub Actions (No Xcode):
```bash
# 1. Upload files to GitHub
# 2. Wait for build (2-3 min)
# 3. Download from Actions → Artifacts
```

### Local (Requires Xcode):
```bash
cd /Users/subhadip.sinha/Downloads/PhoneHasher-Final/final_swift_v2
./build_from_cli.sh
```

---

## 📦 Distribution

### What Gets Built:
```
PhoneHasher-Swift.zip
├── PhoneHasher.app       ← The app
├── INSTALL.command       ← One-click installer
└── README.txt            ← Instructions
```

### Share with Team:
1. Upload ZIP to Google Drive
2. Share link
3. Send these instructions:

```
1. Download and unzip
2. Double-click INSTALL.command
3. Click "Open"
4. Done!
```

---

## 🔧 Installation (For End Users)

### Method 1: INSTALL.command (Easiest)
```
Double-click INSTALL.command → App opens
```

### Method 2: Terminal
```bash
xattr -cr ~/Downloads/PhoneHasher.app && open ~/Downloads/PhoneHasher.app
```

### Method 3: Right-Click
```
Right-click PhoneHasher.app → Open → Open
```

---

## 💡 Key Features

### File Selection:
- Click grey box → Browse files
- Shows selected files
- Clear button appears after selection

### Hash Formats:
- Toggle on LEFT, text on RIGHT
- 4 formats available
- Select one or more

### Output Folder:
- Click grey box → Browse folder
- Shows selected path

### Processing:
- PROCESS FILES button
- Progress bar shows status
- Results dialog when done

---

## ❓ Common Questions

**Q: Clear button missing?**
A: It only appears AFTER selecting files.

**Q: "App is damaged" error?**
A: Double-click INSTALL.command OR run: `xattr -cr PhoneHasher.app`

**Q: Can I remove xattr before distribution?**
A: No - quarantine is added during download. Use INSTALL.command instead.

**Q: Where's the Browse Files button?**
A: Removed in v2! Click the grey box instead.

**Q: Toggle on wrong side?**
A: v1 had toggles on right. v2 has them on left (better UX).

---

## 📁 Files in final_swift_v2

### Core Files:
- `ContentView.swift` - UI (with v2 improvements)
- `PhoneHasherApp.swift` - App entry point
- `Models.swift` - Data models
- `HashProcessor.swift` - Hash logic
- `Info.plist` - App metadata

### Build Files:
- `build_from_cli.sh` - Build script
- `INSTALL.command` - Auto-installer
- `.github/workflows/build.yml` - GitHub Actions

### Documentation:
- `START_HERE_V2.md` - Start here!
- `ANSWERS_TO_YOUR_QUESTIONS.md` - FAQ answers
- `CHANGES_V2.md` - What's new
- `VISUAL_CHANGES.md` - Visual comparison
- `EASY_DISTRIBUTION.md` - Distribution guide
- `INSTALL_COMMAND_EXPLAINED.md` - How installer works
- And more...

---

## 🎓 Documentation Guide

**Just starting?** → `START_HERE_V2.md`
**What changed?** → `CHANGES_V2.md` or `VISUAL_CHANGES.md`
**How to build?** → `GITHUB_QUICK_CHECKLIST.md` (no Xcode) or `CLI_BUILD_GUIDE.md` (with Xcode)
**How to install?** → `INSTALLATION_GUIDE.md` or `FIX_DAMAGED_APP.md`
**How to distribute?** → `EASY_DISTRIBUTION.md`
**Your questions?** → `ANSWERS_TO_YOUR_QUESTIONS.md`

---

## ⚡ Quick Commands

```bash
# Build locally
./build_from_cli.sh

# Fix damaged app
xattr -cr ~/Downloads/PhoneHasher.app && open ~/Downloads/PhoneHasher.app

# Test app
open dist/PhoneHasher.app

# Check ZIP contents
unzip -l dist/PhoneHasher-Swift.zip

# Make INSTALL.command executable (if needed)
chmod +x INSTALL.command
```

---

## 📊 v1 vs v2 Comparison

| Feature | v1 | v2 |
|---------|-------|-------|
| Toggle Position | Right | Left ✨ |
| File Browser | Button | Click box ✨ |
| Folder Browser | Button | Click box ✨ |
| Clear Button | Always visible | Appears when needed ✨ |
| UI Buttons | 3 | 1 ✨ |

---

## ✅ Pre-Distribution Checklist

- [ ] Built app successfully
- [ ] Verified INSTALL.command in ZIP
- [ ] Tested on different Mac
- [ ] Tested INSTALL.command works
- [ ] Verified Clear button appears
- [ ] Verified clickable grey boxes work
- [ ] Verified toggles on left side
- [ ] Created Google Drive folder
- [ ] Uploaded ZIP file
- [ ] Prepared team instructions
- [ ] Tested download from Drive

---

## 🎯 Team Instructions Template

```
PhoneHasher v2 - Installation

DOWNLOAD: [Google Drive Link]

INSTALL (30 seconds):
1. Download PhoneHasher-Swift.zip
2. Unzip
3. Double-click INSTALL.command
4. Click "Open"
5. App opens!

NEW IN v2:
• Click grey boxes to browse (no buttons!)
• Toggle switches on left side
• Cleaner, more intuitive UI

USAGE:
1. Click "No files selected" box → Choose CSV files
2. Toggle hash formats
3. Enter custom column name (optional)
4. Click "No folder selected" box → Choose output
5. Click PROCESS FILES
6. Done!

CLEAR FILES:
After selecting files, click "Clear Selection" button.

Questions? Let me know!
```

---

## 💰 Cost Comparison

| Method | Cost | User Experience |
|--------|------|-----------------|
| **INSTALL.command** | $0 | 3 clicks |
| **Code Signing** | $99/yr | 2 clicks |

**For internal team:** INSTALL.command is perfect!
**For customers:** Consider code signing.

---

## 🆘 Troubleshooting

**Build fails:**
→ Install Xcode OR use GitHub Actions

**"App is damaged":**
→ Use INSTALL.command OR run xattr command

**INSTALL.command opens in editor:**
→ Right-click → Open With → Terminal

**Clear button missing:**
→ It only appears after selecting files (by design!)

**Grey box not clickable:**
→ You're using v1. Use v2 from final_swift_v2 folder.

**Toggle on right side:**
→ You're using v1. Use v2 from final_swift_v2 folder.

---

## 🎉 Summary

**v2 Improvements:**
- Better UI layout
- Fewer clicks needed
- More intuitive design

**Distribution:**
- INSTALL.command included
- Upload ZIP to Drive
- Team installs in 30 seconds

**Everything is ready to go!** 🚀

---

**Questions?** Check the documentation files above!

**Ready?** Build, upload, and share! ✨
