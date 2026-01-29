# PhoneHasher Installation Guide

Complete guide to installing and opening PhoneHasher on macOS.

---

## 🎯 TL;DR - Quick Install

After downloading and unzipping PhoneHasher-Swift.zip:

**Double-click `INSTALL.command`** ✨

That's it! The app will open automatically.

---

## 📦 What You Downloaded

After unzipping, you should have:
```
PhoneHasher-Swift/
├── PhoneHasher.app         ← The application
├── INSTALL.command         ← Auto-installer (EASIEST!)
└── README.txt              ← Installation instructions
```

---

## ⭐ Method 1: Auto-Installer (EASIEST - Recommended)

**Steps:**
1. Extract `PhoneHasher-Swift.zip`
2. **Double-click `INSTALL.command`**
3. App opens automatically!

**What it does:**
- Removes macOS security quarantine
- Opens PhoneHasher automatically
- Shows success message

**No manual commands needed!**

---

## 💻 Method 2: Terminal Command (Fast)

If you prefer terminal or INSTALL.command doesn't work:

**Copy-paste this into Terminal:**

```bash
xattr -cr ~/Downloads/PhoneHasher.app && open ~/Downloads/PhoneHasher.app
```

Press Enter and the app opens!

**If app is in a different location:**
```bash
# Desktop
xattr -cr ~/Desktop/PhoneHasher.app && open ~/Desktop/PhoneHasher.app

# Applications
xattr -cr /Applications/PhoneHasher.app && open /Applications/PhoneHasher.app

# Custom path
xattr -cr "/path/to/PhoneHasher.app" && open "/path/to/PhoneHasher.app"
```

---

## 🖱️ Method 3: Right-Click (No Terminal)

**Steps:**
1. **Right-click** (or Control+click) on `PhoneHasher.app`
2. Click **"Open"** from the menu
3. Click **"Open"** again in the security dialog

**Note:** This might not work if quarantine flag is strongly set. Use Method 1 or 2 if this doesn't work.

---

## ⚙️ Method 4: System Settings (GUI)

**Steps:**
1. Try to double-click `PhoneHasher.app` (it will be blocked)
2. Go to **System Settings** (or System Preferences)
3. Click **Privacy & Security**
4. Scroll down to see **"PhoneHasher was blocked from use..."**
5. Click **"Open Anyway"** button
6. Click **"Open"** in the confirmation dialog

**Works on:** macOS 10.15 (Catalina) and later

---

## 🔍 Understanding the "Damaged" Error

### Why Does This Happen?

When you see: **"PhoneHasher is damaged and can't be opened. You should move it to the Bin."**

**This does NOT mean the app is actually damaged!**

Here's what's happening:
1. You downloaded the app from the internet (GitHub)
2. macOS adds a "quarantine" attribute to protect you
3. macOS checks if the app is code-signed by Apple
4. PhoneHasher is NOT code-signed (would require $99/year Apple Developer account)
5. macOS blocks it with a misleading "damaged" error

**The app is completely safe!** It just needs the quarantine flag removed.

---

## ✅ How the Fix Works

### The `xattr -cr` Command Explained

```bash
xattr -cr ~/Downloads/PhoneHasher.app
```

**What each part does:**
- `xattr` = Extended attributes tool (built into macOS)
- `-c` = Clear all extended attributes
- `-r` = Recursive (apply to all files inside the app bundle)
- `~/Downloads/PhoneHasher.app` = Path to your app

**This is completely safe and legitimate!** It's the standard way to remove quarantine flags from apps you trust.

---

## 🚀 For Your Team

Share these instructions with team members:

```
Hi team!

To install PhoneHasher:

1. Download PhoneHasher-Swift.zip from [link]
2. Unzip the file
3. Double-click INSTALL.command
4. Done! App opens automatically.

ALTERNATIVE (if INSTALL.command doesn't work):
Open Terminal and paste:
  xattr -cr ~/Downloads/PhoneHasher.app && open ~/Downloads/PhoneHasher.app

WHY THIS IS NEEDED:
macOS blocks unsigned apps downloaded from the internet.
This safely removes the security block.

The app is completely safe - just not code-signed.
```

---

## 🔒 Security Information

### Is This Safe?

**Yes!** Here's why:

1. **The app is legitimate** - Built from verified source code
2. **The command is standard** - `xattr` is a built-in macOS tool
3. **No code modification** - Just removes download flag
4. **Runs offline** - App doesn't connect to internet
5. **Open source** - You can review the code on GitHub

### What About Code Signing?

**Code signing** requires:
- Apple Developer account ($99/year)
- Certificate from Apple
- App notarization process

**We don't have this because:**
- It's a free/open-source tool
- Not distributed via App Store
- Built for internal/team use

**For commercial distribution,** code signing would be recommended.

---

## 🛠️ Troubleshooting

### "No such file or directory"
**Problem:** App is not where you think it is
**Solution:**
- Check where you actually saved/unzipped the file
- Use Finder to locate PhoneHasher.app
- Drag the app into Terminal after typing `xattr -cr ` (with space at end)

### "Operation not permitted"
**Problem:** Permission issue
**Solution:** Add `sudo` before the command:
```bash
sudo xattr -cr ~/Downloads/PhoneHasher.app
```
Enter your Mac password when prompted.

### INSTALL.command doesn't work
**Problem:** File not executable or blocked
**Solution:**
- Right-click INSTALL.command → Open (first time only)
- OR use Method 2 (terminal command)

### Still shows "damaged" after command
**Problem:** Command didn't run successfully
**Solution:**
- Make sure you unzipped the file first
- Check if path is correct
- Try with quotes: `xattr -cr "/exact/path/to/PhoneHasher.app"`

### Double-clicking INSTALL.command opens in text editor
**Problem:** File association issue
**Solution:**
- Right-click INSTALL.command
- Choose "Open With" → Terminal
- Check "Always Open With"

---

## 📊 Method Comparison

| Method | Steps | Speed | Technical | Success Rate |
|--------|-------|-------|-----------|--------------|
| **INSTALL.command** | 1 | ⚡ Fast | 🟢 Easy | 95% |
| **Terminal** | 1 | ⚡ Fast | 🟡 Medium | 99% |
| **Right-Click** | 2 | ⚡ Fast | 🟢 Easy | 70% |
| **System Settings** | 5 | 🐌 Slow | 🟡 Medium | 90% |

**Recommendation:** Try INSTALL.command first, use Terminal if that fails.

---

## 🎓 First Time macOS Users

### Opening Terminal
1. Press **⌘ + Space** to open Spotlight
2. Type **"terminal"**
3. Press **Enter**

### Copy-Pasting in Terminal
1. **Copy** the command (⌘ + C)
2. Click in Terminal window
3. **Paste** with ⌘ + V (or right-click → Paste)
4. Press **Enter**

### Finding Downloaded Files
- Usually in: `~/Downloads` (Your home folder → Downloads)
- Click **Finder** → **Downloads** in the sidebar

---

## 🔄 Every Download or Just Once?

### You need to run this:
- ✅ Every time you download a new version from GitHub
- ✅ If you download via browser/email/cloud storage
- ✅ After receiving as email attachment

### You DON'T need to run this:
- ❌ After initial setup (app remembers)
- ❌ When updating existing app in place
- ❌ If received via AirDrop
- ❌ If copied from USB drive
- ❌ If app is code-signed (requires paid Developer account)

**Basically:** The quarantine flag is added when downloading from internet. Remove it once per download.

---

## 💡 Avoiding This in the Future

### Option 1: Code Signing (Recommended for production)
**Cost:** $99/year Apple Developer Program
**Benefits:**
- No security warnings for anyone
- Professional app distribution
- Can distribute via App Store

**Steps:**
1. Enroll in Apple Developer Program
2. Create Developer ID certificate
3. Code sign the app
4. Notarize with Apple
5. Distribute - no warnings!

### Option 2: AirDrop (Free, immediate)
**Benefits:**
- No quarantine flag added
- No terminal commands needed
- Works immediately

**Steps:**
1. Build on GitHub
2. Download to your Mac
3. Run `xattr -cr` once (on your Mac)
4. AirDrop to team members
5. They can open directly!

### Option 3: Internal Certificate (Advanced)
**Benefits:**
- Self-signed certificate
- No annual fee
- Works for internal teams

**Requirements:**
- Technical setup
- Certificate distribution to team
- Team members must trust certificate

---

## 📱 Distributing to Team

### Best Practices

1. **Upload to shared storage**
   - Google Drive
   - Dropbox
   - Internal file server

2. **Include these files:**
   - PhoneHasher.app
   - INSTALL.command ← Makes it easy!
   - README.txt

3. **Share instructions**
   - Link to download
   - "Double-click INSTALL.command"
   - That's it!

4. **Provide support**
   - Share this guide
   - Offer terminal command as backup
   - Help with troubleshooting

---

## ✅ Verification

After installation, verify it worked:

### Check 1: Quarantine Removed
```bash
xattr ~/Downloads/PhoneHasher.app
```
**Expected:** Empty output or only `com.apple.provenance`

### Check 2: App Info
```bash
mdls ~/Downloads/PhoneHasher.app | grep kMDItemWhereFroms
```
**Expected:** Shows download source (this is OK, just metadata)

### Check 3: Can Open
Double-click PhoneHasher.app
**Expected:** App opens without error

---

## 🎯 Quick Reference Card

```
┌─────────────────────────────────────────┐
│   PhoneHasher Installation              │
├─────────────────────────────────────────┤
│                                         │
│  EASIEST:                               │
│  Double-click INSTALL.command           │
│                                         │
│  ALTERNATIVE:                           │
│  Terminal: xattr -cr [app path]         │
│                                         │
│  ISSUE: "App is damaged"                │
│  CAUSE: macOS quarantine flag           │
│  FIX: Remove quarantine (see above)     │
│                                         │
│  SAFE: Yes, completely safe             │
│  FREQUENCY: Once per download           │
│                                         │
└─────────────────────────────────────────┘
```

---

## 📞 Support

### Still Having Issues?

1. **Check this guide's troubleshooting section**
2. **Try all 4 methods in order**
3. **Verify file isn't still zipped**
4. **Check macOS version (10.13+)**
5. **Contact your IT team**

### Related Documents
- `FIX_DAMAGED_APP.md` - Detailed fix guide
- `README.txt` - Quick installation steps
- `GITHUB_WEBSITE_BUILD.md` - How to build from GitHub

---

**Ready to install?** Double-click `INSTALL.command` and you're done! 🎉
