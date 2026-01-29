# GitHub Website Build - Quick Checklist

**Build PhoneHasher Swift app using only your web browser!**

---

## ✅ Quick Steps (10 minutes)

### □ Step 1: Create Repository (2 min)

1. Go to https://github.com/new
2. Repository name: `PhoneHasher`
3. ✅ Check "Add a README file"
4. Visibility: **Public** (required for free builds)
5. Click "Create repository"

---

### □ Step 2: Upload Files (5 min)

**Option A: Upload Entire Folder (FASTEST)**

1. In repository, click "Add file" → "Upload files"
2. Drag folder: `/Users/subhadip.sinha/Downloads/PhoneHasher-Final/PhoneHasher_Swift`
3. Wait for upload
4. Click "Commit changes"

**Option B: Create Files One-by-One**

Upload these files (click "Add file" → "Create new file"):

| File Path | Copy From |
|-----------|-----------|
| `PhoneHasher_Swift/PhoneHasherApp.swift` | `/Users/subhadip.sinha/Downloads/PhoneHasher-Final/PhoneHasher_Swift/PhoneHasherApp.swift` |
| `PhoneHasher_Swift/ContentView.swift` | `...ContentView.swift` |
| `PhoneHasher_Swift/Models.swift` | `...Models.swift` |
| `PhoneHasher_Swift/HashProcessor.swift` | `...HashProcessor.swift` |
| `PhoneHasher_Swift/Info.plist` | `...Info.plist` |
| `PhoneHasher_Swift/build_from_cli.sh` | `...build_from_cli.sh` |

---

### □ Step 3: Add GitHub Actions Workflow (1 min)

1. Click "Add file" → "Create new file"
2. Filename: `.github/workflows/build.yml`
   - GitHub auto-creates folders when you type `/`
3. **Copy-paste this code:**

```yaml
name: Build PhoneHasher Swift App

on:
  push:
    branches: [ main, master ]
  pull_request:
    branches: [ main, master ]
  workflow_dispatch:

jobs:
  build:
    runs-on: macos-latest

    steps:
    - name: Checkout code
      uses: actions/checkout@v4

    - name: Show Xcode version
      run: xcodebuild -version

    - name: Build PhoneHasher app
      run: |
        cd PhoneHasher_Swift
        chmod +x build_from_cli.sh
        ./build_from_cli.sh

    - name: Upload app as artifact
      uses: actions/upload-artifact@v4
      with:
        name: PhoneHasher-Swift
        path: PhoneHasher_Swift/dist/PhoneHasher-Swift.zip
        retention-days: 30

    - name: Upload standalone app
      uses: actions/upload-artifact@v4
      with:
        name: PhoneHasher-App
        path: PhoneHasher_Swift/dist/PhoneHasher.app
        retention-days: 30

    - name: Show build summary
      run: |
        echo "✅ Build completed!"
        ls -lh PhoneHasher_Swift/dist/
```

4. Click "Commit changes"

---

### □ Step 4: Run Build (2 min)

1. Click **"Actions"** tab (top menu)
2. Click "Build PhoneHasher Swift App" (left sidebar)
3. Click **"Run workflow"** button (right side)
4. Click **"Run workflow"** (green button)
5. **Wait 2-3 minutes** for green ✅ checkmark

---

### □ Step 5: Download App (1 min)

1. **Click** on the build with green ✅
2. **Scroll down** to "Artifacts" section
3. **Click** "PhoneHasher-Swift" to download ZIP
4. **Unzip** on your Mac
5. **Open** PhoneHasher.app

**Done!** 🎉

---

## 📋 File Structure Checklist

Your repository should have:

```
PhoneHasher/
├── .github/
│   └── workflows/
│       └── build.yml          ← GitHub Actions config
├── PhoneHasher_Swift/
│   ├── build_from_cli.sh      ← Build script
│   ├── PhoneHasherApp.swift   ← Source files
│   ├── ContentView.swift
│   ├── Models.swift
│   ├── HashProcessor.swift
│   └── Info.plist
└── README.md
```

---

## 🎯 Where to Click

### Create Repository
```
GitHub.com → Top left "New" button (green)
OR: https://github.com/new
```

### Upload Files
```
Repository page → "Add file" button → "Upload files"
```

### Run Build
```
Actions tab → "Run workflow" dropdown → "Run workflow" button
```

### Download App
```
Actions tab → Click green ✅ build → Scroll to "Artifacts"
```

---

## ⚡ Quick Tips

✅ **Repository MUST be Public** for free GitHub Actions
✅ **Upload entire folder** for fastest setup
✅ **Wait for green checkmark** before downloading
✅ **Check spelling** of file paths (case-sensitive!)
✅ **Scroll down** to find Artifacts section

---

## 🔧 Common Issues

| Problem | Solution |
|---------|----------|
| Can't find "Run workflow" button | Make sure you uploaded `build.yml` to `.github/workflows/` |
| Build fails | Check file structure matches checklist above |
| No Artifacts | Build must have green ✅ (not yellow or red) |
| Upload stuck | Try uploading files one by one instead |

---

## 📊 Expected Timeline

| Step | Time |
|------|------|
| Create repository | 1 min |
| Upload files | 3 min |
| Add workflow | 1 min |
| Build runs | 2-3 min |
| Download app | 30 sec |
| **TOTAL** | **~8 minutes** |

---

## ✨ What You'll Get

After completing these steps:

✅ **PhoneHasher.app** - Ready to use macOS application
✅ **Automatic builds** - Rebuilds on every code change
✅ **No Xcode needed** - Builds on GitHub's servers
✅ **Professional setup** - CI/CD pipeline configured
✅ **Easy sharing** - Team downloads from GitHub

---

## 🔄 To Rebuild Later

1. Edit any file on GitHub
2. Commit changes
3. Build runs automatically
4. Download new build from Actions

---

## 📱 Mobile/Tablet Users

This works on **any device with a web browser**:
- ✅ Mac
- ✅ Windows PC
- ✅ iPad
- ✅ iPhone
- ✅ Android

You can upload files and trigger builds from anywhere!

---

## 🎓 First Time Using GitHub?

**Don't worry!** This guide is designed for beginners.

**Key terms:**
- **Repository** = Project folder
- **Commit** = Save changes
- **Actions** = Automated tasks (like building your app)
- **Artifacts** = Built files you can download
- **Workflow** = Instructions for GitHub Actions

---

## 🆘 Stuck?

**Full detailed guide:** `GITHUB_WEBSITE_BUILD.md`

**Questions:**
1. Is repository Public? (check Settings)
2. Did you upload `build.yml` to `.github/workflows/`?
3. Are all files in `PhoneHasher_Swift/` folder?
4. Does build have green ✅ checkmark?

---

## 🎉 Success Indicators

You'll know it worked when:
1. ✅ Actions tab shows green checkmark
2. ✅ Build logs say "Build completed successfully!"
3. ✅ Artifacts section appears
4. ✅ PhoneHasher-Swift.zip downloads
5. ✅ App opens on your Mac

---

**Ready?** Start here: https://github.com/new 🚀

**Time needed:** 10 minutes ⏱️

**Cost:** $0 (100% free) 💰
