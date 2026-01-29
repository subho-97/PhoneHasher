# Build PhoneHasher Swift Using GitHub Website Only

Complete guide to build the app **using only GitHub.com** - no command line, no terminal, no git commands!

---

## 📋 What You'll Do

1. Create GitHub repository (2 minutes)
2. Upload files via web browser (3 minutes)
3. Wait for automatic build (2-3 minutes)
4. Download built app (1 minute)

**Total time: ~10 minutes**

---

## 🚀 Step-by-Step Instructions

### Step 1: Create GitHub Account (if you don't have one)

1. Go to https://github.com/signup
2. Enter email, password, username
3. Verify email
4. Done! (Free account is fine)

---

### Step 2: Create New Repository

1. **Go to GitHub:** https://github.com
2. **Click** the green **"New"** button (top left, or go to https://github.com/new)
3. **Fill in:**
   - **Repository name:** `PhoneHasher` (or any name you want)
   - **Description:** `PhoneHasher Swift App - Phone number hashing tool`
   - **Visibility:** Public (required for free GitHub Actions)
   - **Initialize:** ✅ Check "Add a README file"
4. **Click** green **"Create repository"** button

You now have an empty repository!

---

### Step 3: Upload PhoneHasher Files

#### 3a. Create Folder Structure

1. **In your repository,** click **"Add file"** → **"Create new file"**

2. **In the filename box,** type: `.github/workflows/build.yml`
   - This creates the folders `.github` and `workflows` automatically
   - GitHub will show: `.github / workflows / build.yml`

3. **Copy-paste this content** into the file editor:

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
        echo "✅ Build completed successfully!"
        echo ""
        echo "📦 Built files:"
        ls -lh PhoneHasher_Swift/dist/
        echo ""
        echo "🎉 Download the artifacts from the GitHub Actions page"
```

4. **Scroll down** and click **"Commit changes"**
5. Click **"Commit changes"** again in the popup

---

#### 3b. Create PhoneHasher_Swift Folder

1. **Click** "Add file" → "Create new file"
2. **Type:** `PhoneHasher_Swift/build_from_cli.sh`
3. **Open this file on your Mac:**
   `/Users/subhadip.sinha/Downloads/PhoneHasher-Final/PhoneHasher_Swift/build_from_cli.sh`
4. **Copy ALL the contents** from that file
5. **Paste** into GitHub's editor
6. **Click** "Commit changes" → "Commit changes"

---

#### 3c. Upload Swift Source Files

Now upload each Swift source file:

**File 1: PhoneHasherApp.swift**
1. Click "Add file" → "Create new file"
2. Type: `PhoneHasher_Swift/PhoneHasherApp.swift`
3. Open `/Users/subhadip.sinha/Downloads/PhoneHasher-Final/PhoneHasher_Swift/PhoneHasherApp.swift`
4. Copy all contents and paste into GitHub
5. Commit changes

**File 2: ContentView.swift**
1. Click "Add file" → "Create new file"
2. Type: `PhoneHasher_Swift/ContentView.swift`
3. Open `/Users/subhadip.sinha/Downloads/PhoneHasher-Final/PhoneHasher_Swift/ContentView.swift`
4. Copy all contents and paste into GitHub
5. Commit changes

**File 3: Models.swift**
1. Click "Add file" → "Create new file"
2. Type: `PhoneHasher_Swift/Models.swift`
3. Open `/Users/subhadip.sinha/Downloads/PhoneHasher-Final/PhoneHasher_Swift/Models.swift`
4. Copy all contents and paste into GitHub
5. Commit changes

**File 4: HashProcessor.swift**
1. Click "Add file" → "Create new file"
2. Type: `PhoneHasher_Swift/HashProcessor.swift`
3. Open `/Users/subhadip.sinha/Downloads/PhoneHasher-Final/PhoneHasher_Swift/HashProcessor.swift`
4. Copy all contents and paste into GitHub
5. Commit changes

**File 5: Info.plist**
1. Click "Add file" → "Create new file"
2. Type: `PhoneHasher_Swift/Info.plist`
3. Open `/Users/subhadip.sinha/Downloads/PhoneHasher-Final/PhoneHasher_Swift/Info.plist`
4. Copy all contents and paste into GitHub
5. Commit changes

---

### Step 4: Trigger the Build

GitHub Actions should automatically start building after you upload the files.

**To manually trigger a build:**

1. **Click** the **"Actions"** tab (top menu)
2. **Click** "Build PhoneHasher Swift App" (left sidebar)
3. **Click** the blue **"Run workflow"** dropdown (right side)
4. **Click** green **"Run workflow"** button
5. **Wait** 2-3 minutes for build to complete

You'll see:
- 🟡 Yellow dot = Building...
- ✅ Green checkmark = Success!
- ❌ Red X = Failed (click to see logs)

---

### Step 5: Download the Built App

1. **In the Actions tab,** click on the **green checkmark** build
2. **Scroll down** to the **"Artifacts"** section
3. **Download:**
   - `PhoneHasher-Swift` - ZIP file with app and README (~3-5 MB)
   - `PhoneHasher-App` - Just the .app file

4. **Unzip** on your Mac
5. **Open** PhoneHasher.app

---

## 🎯 Quick Method: Upload Entire Folder

Instead of creating files one by one, you can upload the whole folder:

1. **In your repository,** click **"Add file"** → **"Upload files"**
2. **On your Mac,** open Finder
3. **Navigate to:** `/Users/subhadip.sinha/Downloads/PhoneHasher-Final/`
4. **Drag the `PhoneHasher_Swift` folder** into the GitHub upload area
5. **Wait** for all files to upload
6. **Click** "Commit changes"

**Then upload the workflow file:**
1. Click "Add file" → "Create new file"
2. Type: `.github/workflows/build.yml`
3. Paste the workflow content (from Step 3a above)
4. Commit changes

**Done!** Build will start automatically.

---

## 📦 What Happens During Build

GitHub will:
1. ✅ Spin up a macOS virtual machine (with Xcode installed)
2. ✅ Download your code
3. ✅ Run `build_from_cli.sh`
4. ✅ Build PhoneHasher.app
5. ✅ Package it as PhoneHasher-Swift.zip
6. ✅ Upload as downloadable artifact
7. ✅ Keep it for 30 days

**You get:** A fully built macOS app without installing Xcode!

---

## 🔄 Making Changes and Rebuilding

After the initial setup, to rebuild with changes:

1. **Edit a file** (click filename → Edit button ✏️)
2. **Make changes**
3. **Commit changes**
4. **GitHub automatically rebuilds!** (2-3 minutes)
5. **Download** new build from Actions tab

---

## 🎬 Visual Guide

### Creating the Repository
```
GitHub.com → New button → Fill form → Create repository
```

### Uploading Files
```
Repository → Add file → Upload files → Drag folder → Commit
```

### Triggering Build
```
Actions tab → Build workflow → Run workflow → Wait for ✅
```

### Downloading App
```
Actions tab → Click ✅ build → Scroll to Artifacts → Download
```

---

## 📊 File Checklist

Make sure you uploaded these files:

- ✅ `.github/workflows/build.yml` (GitHub Actions config)
- ✅ `PhoneHasher_Swift/build_from_cli.sh` (Build script)
- ✅ `PhoneHasher_Swift/PhoneHasherApp.swift` (Source code)
- ✅ `PhoneHasher_Swift/ContentView.swift` (Source code)
- ✅ `PhoneHasher_Swift/Models.swift` (Source code)
- ✅ `PhoneHasher_Swift/HashProcessor.swift` (Source code)
- ✅ `PhoneHasher_Swift/Info.plist` (App metadata)

**Your repository should look like:**
```
PhoneHasher/
├── .github/
│   └── workflows/
│       └── build.yml
├── PhoneHasher_Swift/
│   ├── build_from_cli.sh
│   ├── PhoneHasherApp.swift
│   ├── ContentView.swift
│   ├── Models.swift
│   ├── HashProcessor.swift
│   └── Info.plist
└── README.md
```

---

## 🔧 Troubleshooting

### Build Fails
**Click on the red X** → Read the error log → Common issues:
- Missing files: Upload all required files
- Wrong folder structure: Files must be in `PhoneHasher_Swift/` folder
- Syntax error: Check `.github/workflows/build.yml` format

### Can't Find Artifacts
**Make sure:**
- Build has green checkmark ✅
- You clicked on the specific build (not just the Actions tab)
- Scrolled down to "Artifacts" section

### Build Takes Too Long
- Normal: 2-3 minutes
- If stuck: Cancel and run again
- If always fails: Check error logs

### Repository Not Public
GitHub Actions is free for **public repositories** only.
- Go to Settings → Scroll to bottom → Change visibility to Public

---

## 💡 Pro Tips

### Tip 1: Use Upload Folder Feature
Fastest way: Drag entire `PhoneHasher_Swift` folder into GitHub upload

### Tip 2: Manual Triggers
Use "Run workflow" button to rebuild anytime without making code changes

### Tip 3: Check Build Status
Green ✅ = Success, download ready!
Yellow 🟡 = Building, wait...
Red ❌ = Failed, check logs

### Tip 4: Share with Team
Give team members the repository URL → They can download from Actions → Artifacts

---

## 🎯 Summary

**What you need:**
- GitHub account (free)
- Web browser
- 10 minutes

**What you get:**
- Fully built PhoneHasher.app
- Automatic rebuilds on changes
- No Xcode installation needed
- Professional CI/CD setup

**Steps:**
1. Create repository on GitHub.com
2. Upload PhoneHasher_Swift folder
3. Upload .github/workflows/build.yml
4. Wait for build
5. Download from Artifacts

---

## 📸 Screenshot Guide

### Where to Find Things

**Actions Tab:**
- Top menu bar of your repository
- Next to "Pull requests" and "Projects"

**Run Workflow Button:**
- Actions tab → Right side of page
- Blue dropdown button

**Artifacts Section:**
- Click a specific build
- Scroll to bottom
- See "Artifacts" heading with download links

**Add File Button:**
- Top right of file list
- Shows "Add file" dropdown
- Choose "Create new file" or "Upload files"

---

## ✅ Success Checklist

After following this guide, you should have:

- ✅ GitHub repository created
- ✅ All files uploaded
- ✅ Build workflow configured
- ✅ First build completed successfully (green ✅)
- ✅ PhoneHasher.app downloaded to your Mac
- ✅ App opens and works

**Congratulations!** You've built a macOS app using GitHub Actions! 🎉

---

## 🆘 Need Help?

**Problem:** Can't create repository
**Solution:** Make sure you're logged into GitHub

**Problem:** Upload fails
**Solution:** Try uploading files one by one instead of all at once

**Problem:** Build fails immediately
**Solution:** Check that `build.yml` is in `.github/workflows/` folder (exact path)

**Problem:** No Artifacts section
**Solution:** Wait for build to complete (green ✅), then scroll down

---

## 🔗 Useful Links

- GitHub Signup: https://github.com/signup
- Create Repository: https://github.com/new
- GitHub Actions Docs: https://docs.github.com/en/actions

---

## 📞 What's Next?

**After first successful build:**
- Share repository URL with team
- They can download built app from Actions
- Make changes directly on GitHub
- Automatic rebuilds on every change

**Want to customize?**
- Edit Swift files on GitHub
- Commit changes
- New build starts automatically
- Download updated app

---

**Ready to start?** Go to https://github.com/new and create your repository! 🚀

**Estimated time:** 10 minutes from start to finish!
