# PhoneHasher Swift v2 🔐

**Native macOS app for secure SHA-256 phone number hashing**

Version 2.0 - Improved UI with better UX

---

## 🎉 New in v2

✨ **Toggle switches on LEFT side** (more intuitive)
✨ **Clickable grey boxes** (no separate browse buttons)
✨ **Clear button** (appears when files selected)
✨ **Cleaner interface** (fewer buttons, more modern)

See `CHANGES_V2.md` for full details.

---

## 🚀 Quick Start

### For Users (Installing the App):

1. **Download** PhoneHasher-Swift.zip
2. **Unzip** the file
3. **Double-click** INSTALL.command
4. **Click** "Open" when prompted
5. **Done!** App opens automatically

### For Developers (Building the App):

**Option 1: GitHub Actions (No Xcode!)**
- Upload files to GitHub
- Builds automatically in cloud
- Download from Actions → Artifacts
- See: `GITHUB_QUICK_CHECKLIST.md`

**Option 2: Local Build (Requires Xcode)**
```bash
./build_from_cli.sh
```
See: `CLI_BUILD_GUIDE.md`

---

## 📦 What's Included

After building, you get:
- **PhoneHasher.app** - The application
- **INSTALL.command** - One-click installer (removes security warnings)
- **README.txt** - Installation instructions

---

## ✨ Features

### File Selection
- Click grey box to browse CSV files
- Select up to 5 files at once
- Clear button to remove selection

### Hash Formats (4 options)
- 10-digit format (9876543210)
- +91 format (+919876543210)
- 91 format with custom header (919876543210)
- Truecaller format (91 prefix, no header)

### Output Settings
- Custom column naming
- Organized output folders (one per format)
- Progress tracking during processing

### Performance
- Fast processing (1M rows in ~30-40 seconds)
- Handles large CSV files
- Native Swift performance

---

## 🎯 Use Cases

- **Marketing Teams:** Hash user phone numbers for ad platforms
- **Analytics:** Prepare data for 3P platforms (Google, Facebook, etc.)
- **Privacy:** Hash PII before sharing with partners
- **Data Processing:** Bulk phone number transformation

---

## 💡 UI Improvements (v2)

### Before (v1):
```
Hash for 3P Platforms              [ON]  ← Toggle on right
┌─────────────────┐
│  No files       │  ← Not clickable
└─────────────────┘
[Browse Files]      ← Separate button
```

### After (v2):
```
[ON]  Hash for 3P Platforms            ← Toggle on left!
┌─────────────────┐
│  No files       │  ← CLICKABLE!
│ (Click to browse)│
└─────────────────┘
(No button needed!)                     ← Cleaner!
```

---

## 📖 Documentation

### Start Here:
- `START_HERE_V2.md` - Quick start guide
- `QUICK_REFERENCE.md` - One-page reference

### What's New:
- `CHANGES_V2.md` - Detailed change log
- `VISUAL_CHANGES.md` - Visual comparison
- `ANSWERS_TO_YOUR_QUESTIONS.md` - FAQ

### Building:
- `GITHUB_QUICK_CHECKLIST.md` - Build on GitHub (no Xcode)
- `BUILD_WITHOUT_XCODE.md` - Build without local Xcode
- `CLI_BUILD_GUIDE.md` - Build locally with Xcode

### Installing & Distributing:
- `INSTALLATION_GUIDE.md` - How to install
- `FIX_DAMAGED_APP.md` - Fix security warnings
- `EASY_DISTRIBUTION.md` - How to share with team
- `INSTALL_COMMAND_EXPLAINED.md` - How auto-installer works

---

## 🔧 Requirements

### To Build:
- macOS 13.0+
- Xcode (for local builds) OR GitHub account (for cloud builds)

### To Run:
- macOS 13.0+
- No other dependencies!

---

## ⚡ Quick Commands

```bash
# Build locally
./build_from_cli.sh

# Fix "damaged app" error
xattr -cr ~/Downloads/PhoneHasher.app && open ~/Downloads/PhoneHasher.app

# Or just double-click
INSTALL.command

# Test the app
open dist/PhoneHasher.app
```

---

## 🎓 How to Use

1. **Select Files:** Click grey box → Choose CSV files (up to 5)
2. **Choose Formats:** Toggle one or more hash formats
3. **Set Column Name:** Enter custom column name (optional)
4. **Select Output:** Click grey box → Choose output folder
5. **Process:** Click PROCESS FILES button
6. **Done:** Files saved to output folder (organized by format)

---

## 📊 Performance

- **10,000 rows:** ~1 second
- **100,000 rows:** ~3 seconds
- **1,000,000 rows:** ~30-40 seconds
- **Memory:** Efficient CSV streaming
- **App Size:** ~5-8 MB (native Swift)

---

## 🔒 Security & Privacy

- ✅ **100% offline** - No internet connection required
- ✅ **SHA-256 hashing** - Industry standard
- ✅ **No data storage** - Files processed locally only
- ✅ **Open source** - Code available for review
- ✅ **Native app** - No external dependencies

---

## 🆚 Why v2?

| Aspect | v1 | v2 |
|--------|-------|-------|
| Toggle Position | Right (confusing) | Left (standard) |
| File Selection | Separate button | Click placeholder |
| Folder Selection | Separate button | Click placeholder |
| UI Complexity | 3 buttons | 1 button |
| User Experience | Good | Excellent ✨ |

**Same power, better UX!**

---

## 🐛 Troubleshooting

**"App is damaged and can't be opened"**
→ Double-click INSTALL.command OR run: `xattr -cr PhoneHasher.app`

**"INSTALL.command opens in text editor"**
→ Right-click → Open With → Terminal

**"Clear button missing"**
→ It only appears after you select files (by design!)

**"Can't click grey box"**
→ You're using v1. Use v2 from final_swift_v2 folder

**Build fails**
→ Install Xcode OR use GitHub Actions (no Xcode needed!)

---

## 💰 Cost

- **App:** FREE
- **Building:** FREE (GitHub Actions) or FREE (local Xcode)
- **Code Signing (optional):** $99/year (Apple Developer Program)

**Current setup works great for internal teams without code signing!**

---

## 🤝 Contributing

Built for internal use at fintech organization.

**Improvements welcome:**
- UI enhancements
- Performance optimizations
- Additional hash formats
- Bug fixes

---

## 📞 Support

**Documentation:** Check the docs folder
**Installation Issues:** See `FIX_DAMAGED_APP.md`
**Build Issues:** See `CLI_BUILD_GUIDE.md`
**Distribution:** See `EASY_DISTRIBUTION.md`

---

## 🎯 Project Structure

```
final_swift_v2/
├── Core Swift Files
│   ├── ContentView.swift        (UI with v2 improvements)
│   ├── PhoneHasherApp.swift     (App entry point)
│   ├── Models.swift              (Data models)
│   ├── HashProcessor.swift       (Hash logic)
│   └── Info.plist               (App metadata)
│
├── Build Files
│   ├── build_from_cli.sh        (Build script)
│   ├── INSTALL.command           (Auto-installer)
│   └── .github/workflows/build.yml (GitHub Actions)
│
└── Documentation
    ├── START_HERE_V2.md          (Quick start)
    ├── QUICK_REFERENCE.md        (One-page reference)
    ├── CHANGES_V2.md             (What's new)
    └── [more docs...]
```

---

## 📝 License

Built for internal use. Modify as needed for your organization.

---

## 🎉 Ready to Use!

**For Users:**
1. Get PhoneHasher-Swift.zip
2. Double-click INSTALL.command
3. Start hashing!

**For Developers:**
1. Read `START_HERE_V2.md`
2. Build using GitHub Actions or locally
3. Distribute to team

**Questions?** Check the documentation files! 📚

---

**PhoneHasher v2** - Secure, Fast, Native macOS Phone Hashing 🔐✨
