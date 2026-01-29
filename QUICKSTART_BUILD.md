# PhoneHasher Swift - Quick Start

Choose your build method:

---

## 🚀 FASTEST: GitHub Actions (No Xcode needed!)

**Time:** 5 minutes setup, 2-3 min per build
**Requirements:** GitHub account (free)

```bash
# Push to GitHub
git init
git add PhoneHasher_Swift/
git commit -m "Add app"
git remote add origin https://github.com/YOUR_USERNAME/PhoneHasher.git
git push -u origin main

# GitHub builds automatically
# Download from: Actions tab → Latest build → Artifacts
```

✅ No Xcode installation
✅ Free
✅ Automatic builds

📖 **Full guide:** `BUILD_WITHOUT_XCODE.md` → Option 1

---

## 💻 LOCAL: Install Xcode (One-time)

**Time:** 60 min install, 30 sec per build
**Requirements:** 12 GB disk space

```bash
# 1. Install Xcode from App Store (free, one-time)

# 2. Switch to Xcode
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# 3. Build
./build_from_cli.sh

# Done! App in: dist/PhoneHasher.app
```

✅ Fast local builds
✅ No internet needed
✅ Full control

📖 **Full guide:** `CLI_BUILD_GUIDE.md`

---

## 🎨 GUI: Xcode Interface

**Time:** 60 min install, 20 sec per build
**Requirements:** Xcode.app

```
1. Open Xcode
2. Create new macOS App project
3. Replace files with our Swift files
4. Click Run ▶
```

✅ Visual interface
✅ Easy debugging
✅ Standard workflow

📖 **Full guide:** `BUILD_INSTRUCTIONS.md`

---

## 📋 Comparison

| Method | Setup | Build | Best For |
|--------|-------|-------|----------|
| **GitHub Actions** | 5 min | 2-3 min | Teams, no Xcode |
| **CLI (Xcode)** | 60 min | 30 sec | Developers |
| **GUI (Xcode)** | 60 min | 20 sec | Beginners |

---

## ❓ Which Should I Use?

**Don't want to install Xcode?** → GitHub Actions
**Want fastest builds?** → Local Xcode CLI
**New to development?** → Xcode GUI

---

## 📚 Documentation

- `BUILD_WITHOUT_XCODE.md` - Build without installing Xcode
- `CLI_BUILD_GUIDE.md` - Command line build guide
- `BUILD_INSTRUCTIONS.md` - Xcode GUI instructions
- `README.md` - Project overview

---

## 🆘 Help

**Problem:** "xcodebuild requires Xcode"
**Solution:** Install Xcode OR use GitHub Actions

**Problem:** "No such file"
**Solution:** Make sure you're in PhoneHasher_Swift/ folder

**Problem:** Build fails
**Solution:** Check `.github/workflows/build.yml` logs

---

**Ready?** Pick a method above and start building! 🎉
