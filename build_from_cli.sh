#!/bin/bash

# PhoneHasher Swift - Command Line Build Script
# Builds the app without opening Xcode GUI

set -e

echo "=========================================="
echo "PhoneHasher Swift - CLI Build"
echo "=========================================="
echo ""

# Configuration
APP_NAME="PhoneHasher"
BUNDLE_ID="com.phonehash.app"
PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
BUILD_DIR="$PROJECT_DIR/build"
DERIVED_DATA="$PROJECT_DIR/DerivedData"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}Step 1: Checking prerequisites...${NC}"

# Check if xcodebuild is available
if ! command -v xcodebuild &> /dev/null; then
    echo "❌ ERROR: xcodebuild not found"
    echo ""
    echo "This requires Xcode.app (not just Command Line Tools)"
    echo ""
    echo "OPTIONS:"
    echo "1. Install Xcode from App Store (FREE):"
    echo "   https://apps.apple.com/app/xcode/id497799835"
    echo ""
    echo "2. OR use GitHub Actions (no local Xcode needed):"
    echo "   See CLI_BUILD_GUIDE.md"
    echo ""
    exit 1
fi

# Check if we're using full Xcode (not just command line tools)
XCODE_PATH=$(xcode-select -p)
if [[ "$XCODE_PATH" == *"CommandLineTools"* ]]; then
    echo "❌ ERROR: xcodebuild requires full Xcode.app"
    echo ""
    echo "Current developer directory: $XCODE_PATH"
    echo ""
    echo "SOLUTIONS:"
    echo ""
    echo "1. Install Xcode from App Store (FREE):"
    echo "   https://apps.apple.com/app/xcode/id497799835"
    echo ""
    echo "2. Then switch to Xcode:"
    echo "   sudo xcode-select -s /Applications/Xcode.app/Contents/Developer"
    echo ""
    echo "3. OR use GitHub Actions (builds on GitHub, no local Xcode):"
    echo "   See CLI_BUILD_GUIDE.md section on GitHub Actions"
    echo ""
    exit 1
fi

# Check if we have the source files
if [ ! -f "$PROJECT_DIR/PhoneHasherApp.swift" ]; then
    echo "❌ ERROR: Source files not found in $PROJECT_DIR"
    exit 1
fi

echo -e "${GREEN}✓ Prerequisites OK${NC}"
echo ""

echo -e "${BLUE}Step 2: Creating Xcode project structure...${NC}"

# Create project directory structure
mkdir -p "$BUILD_DIR"
mkdir -p "$PROJECT_DIR/$APP_NAME"

# Copy source files to project directory
cp "$PROJECT_DIR/PhoneHasherApp.swift" "$PROJECT_DIR/$APP_NAME/"
cp "$PROJECT_DIR/ContentView.swift" "$PROJECT_DIR/$APP_NAME/"
cp "$PROJECT_DIR/Models.swift" "$PROJECT_DIR/$APP_NAME/"
cp "$PROJECT_DIR/HashProcessor.swift" "$PROJECT_DIR/$APP_NAME/"

# Create Info.plist if it doesn't exist
if [ ! -f "$PROJECT_DIR/$APP_NAME/Info.plist" ]; then
    cat > "$PROJECT_DIR/$APP_NAME/Info.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>CFBundleDevelopmentRegion</key>
    <string>en</string>
    <key>CFBundleExecutable</key>
    <string>$(EXECUTABLE_NAME)</string>
    <key>CFBundleIdentifier</key>
    <string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>
    <key>CFBundleInfoDictionaryVersion</key>
    <string>6.0</string>
    <key>CFBundleName</key>
    <string>$(PRODUCT_NAME)</string>
    <key>CFBundlePackageType</key>
    <string>APPL</string>
    <key>CFBundleShortVersionString</key>
    <string>1.0</string>
    <key>CFBundleVersion</key>
    <string>1</string>
    <key>LSMinimumSystemVersion</key>
    <string>13.0</string>
    <key>NSHumanReadableCopyright</key>
    <string>Copyright © 2026. All rights reserved.</string>
    <key>NSPrincipalClass</key>
    <string>NSApplication</string>
</dict>
</plist>
EOF
fi

# Create project.pbxproj file
mkdir -p "$PROJECT_DIR/$APP_NAME.xcodeproj"

cat > "$PROJECT_DIR/$APP_NAME.xcodeproj/project.pbxproj" << 'PBXPROJ'
// !$*UTF8*$!
{
	archiveVersion = 1;
	classes = {
	};
	objectVersion = 56;
	objects = {

/* Begin PBXBuildFile section */
		A1000001000000000000001 /* PhoneHasherApp.swift in Sources */ = {isa = PBXBuildFile; fileRef = A2000001000000000000001 /* PhoneHasherApp.swift */; };
		A1000002000000000000001 /* ContentView.swift in Sources */ = {isa = PBXBuildFile; fileRef = A2000002000000000000001 /* ContentView.swift */; };
		A1000003000000000000001 /* Models.swift in Sources */ = {isa = PBXBuildFile; fileRef = A2000003000000000000001 /* Models.swift */; };
		A1000004000000000000001 /* HashProcessor.swift in Sources */ = {isa = PBXBuildFile; fileRef = A2000004000000000000001 /* HashProcessor.swift */; };
/* End PBXBuildFile section */

/* Begin PBXFileReference section */
		A2000001000000000000001 /* PhoneHasherApp.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = PhoneHasherApp.swift; sourceTree = "<group>"; };
		A2000002000000000000001 /* ContentView.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = ContentView.swift; sourceTree = "<group>"; };
		A2000003000000000000001 /* Models.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = Models.swift; sourceTree = "<group>"; };
		A2000004000000000000001 /* HashProcessor.swift */ = {isa = PBXFileReference; lastKnownFileType = sourcecode.swift; path = HashProcessor.swift; sourceTree = "<group>"; };
		A3000001000000000000001 /* PhoneHasher.app */ = {isa = PBXFileReference; explicitFileType = wrapper.application; includeInIndex = 0; path = PhoneHasher.app; sourceTree = BUILT_PRODUCTS_DIR; };
		A4000001000000000000001 /* Info.plist */ = {isa = PBXFileReference; lastKnownFileType = text.plist.xml; path = Info.plist; sourceTree = "<group>"; };
/* End PBXFileReference section */

/* Begin PBXFrameworksBuildPhase section */
		A5000001000000000000001 /* Frameworks */ = {
			isa = PBXFrameworksBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXFrameworksBuildPhase section */

/* Begin PBXGroup section */
		A6000001000000000000001 = {
			isa = PBXGroup;
			children = (
				A6000002000000000000001 /* PhoneHasher */,
				A6000003000000000000001 /* Products */,
			);
			sourceTree = "<group>";
		};
		A6000002000000000000001 /* PhoneHasher */ = {
			isa = PBXGroup;
			children = (
				A2000001000000000000001 /* PhoneHasherApp.swift */,
				A2000002000000000000001 /* ContentView.swift */,
				A2000003000000000000001 /* Models.swift */,
				A2000004000000000000001 /* HashProcessor.swift */,
				A4000001000000000000001 /* Info.plist */,
			);
			path = PhoneHasher;
			sourceTree = "<group>";
		};
		A6000003000000000000001 /* Products */ = {
			isa = PBXGroup;
			children = (
				A3000001000000000000001 /* PhoneHasher.app */,
			);
			name = Products;
			sourceTree = "<group>";
		};
/* End PBXGroup section */

/* Begin PBXNativeTarget section */
		A7000001000000000000001 /* PhoneHasher */ = {
			isa = PBXNativeTarget;
			buildConfigurationList = A8000001000000000000001 /* Build configuration list for PBXNativeTarget "PhoneHasher" */;
			buildPhases = (
				A9000001000000000000001 /* Sources */,
				A5000001000000000000001 /* Frameworks */,
				AA000001000000000000001 /* Resources */,
			);
			buildRules = (
			);
			dependencies = (
			);
			name = PhoneHasher;
			productName = PhoneHasher;
			productReference = A3000001000000000000001 /* PhoneHasher.app */;
			productType = "com.apple.product-type.application";
		};
/* End PBXNativeTarget section */

/* Begin PBXProject section */
		AB000001000000000000001 /* Project object */ = {
			isa = PBXProject;
			attributes = {
				BuildIndependentTargetsInParallel = 1;
				LastSwiftUpdateCheck = 1500;
				LastUpgradeCheck = 1500;
			};
			buildConfigurationList = AC000001000000000000001 /* Build configuration list for PBXProject "PhoneHasher" */;
			compatibilityVersion = "Xcode 14.0";
			developmentRegion = en;
			hasScannedForEncodings = 0;
			knownRegions = (
				en,
				Base,
			);
			mainGroup = A6000001000000000000001;
			productRefGroup = A6000003000000000000001 /* Products */;
			projectDirPath = "";
			projectRoot = "";
			targets = (
				A7000001000000000000001 /* PhoneHasher */,
			);
		};
/* End PBXProject section */

/* Begin PBXResourcesBuildPhase section */
		AA000001000000000000001 /* Resources */ = {
			isa = PBXResourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXResourcesBuildPhase section */

/* Begin PBXSourcesBuildPhase section */
		A9000001000000000000001 /* Sources */ = {
			isa = PBXSourcesBuildPhase;
			buildActionMask = 2147483647;
			files = (
				A1000001000000000000001 /* PhoneHasherApp.swift in Sources */,
				A1000002000000000000001 /* ContentView.swift in Sources */,
				A1000003000000000000001 /* Models.swift in Sources */,
				A1000004000000000000001 /* HashProcessor.swift in Sources */,
			);
			runOnlyForDeploymentPostprocessing = 0;
		};
/* End PBXSourcesBuildPhase section */

/* Begin XCBuildConfiguration section */
		AD000001000000000000001 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = dwarf;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				ENABLE_TESTABILITY = YES;
				GCC_C_LANGUAGE_STANDARD = gnu11;
				GCC_DYNAMIC_NO_PIC = NO;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_OPTIMIZATION_LEVEL = 0;
				GCC_PREPROCESSOR_DEFINITIONS = (
					"DEBUG=1",
					"$(inherited)",
				);
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				MACOSX_DEPLOYMENT_TARGET = 13.0;
				MTL_ENABLE_DEBUG_INFO = INCLUDE_SOURCE;
				MTL_FAST_MATH = YES;
				ONLY_ACTIVE_ARCH = YES;
				SDKROOT = macosx;
				SWIFT_ACTIVE_COMPILATION_CONDITIONS = DEBUG;
				SWIFT_OPTIMIZATION_LEVEL = "-Onone";
			};
			name = Debug;
		};
		AE000001000000000000001 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ALWAYS_SEARCH_USER_PATHS = NO;
				CLANG_ANALYZER_NONNULL = YES;
				CLANG_ANALYZER_NUMBER_OBJECT_CONVERSION = YES_AGGRESSIVE;
				CLANG_CXX_LANGUAGE_STANDARD = "gnu++20";
				CLANG_ENABLE_MODULES = YES;
				CLANG_ENABLE_OBJC_ARC = YES;
				CLANG_ENABLE_OBJC_WEAK = YES;
				CLANG_WARN_BLOCK_CAPTURE_AUTORELEASING = YES;
				CLANG_WARN_BOOL_CONVERSION = YES;
				CLANG_WARN_COMMA = YES;
				CLANG_WARN_CONSTANT_CONVERSION = YES;
				CLANG_WARN_DEPRECATED_OBJC_IMPLEMENTATIONS = YES;
				CLANG_WARN_DIRECT_OBJC_ISA_USAGE = YES_ERROR;
				CLANG_WARN_DOCUMENTATION_COMMENTS = YES;
				CLANG_WARN_EMPTY_BODY = YES;
				CLANG_WARN_ENUM_CONVERSION = YES;
				CLANG_WARN_INFINITE_RECURSION = YES;
				CLANG_WARN_INT_CONVERSION = YES;
				CLANG_WARN_NON_LITERAL_NULL_CONVERSION = YES;
				CLANG_WARN_OBJC_IMPLICIT_RETAIN_SELF = YES;
				CLANG_WARN_OBJC_LITERAL_CONVERSION = YES;
				CLANG_WARN_OBJC_ROOT_CLASS = YES_ERROR;
				CLANG_WARN_QUOTED_INCLUDE_IN_FRAMEWORK_HEADER = YES;
				CLANG_WARN_RANGE_LOOP_ANALYSIS = YES;
				CLANG_WARN_STRICT_PROTOTYPES = YES;
				CLANG_WARN_SUSPICIOUS_MOVE = YES;
				CLANG_WARN_UNGUARDED_AVAILABILITY = YES_AGGRESSIVE;
				CLANG_WARN_UNREACHABLE_CODE = YES;
				CLANG_WARN__DUPLICATE_METHOD_MATCH = YES;
				COPY_PHASE_STRIP = NO;
				DEBUG_INFORMATION_FORMAT = "dwarf-with-dsym";
				ENABLE_NS_ASSERTIONS = NO;
				ENABLE_STRICT_OBJC_MSGSEND = YES;
				GCC_C_LANGUAGE_STANDARD = gnu11;
				GCC_NO_COMMON_BLOCKS = YES;
				GCC_WARN_64_TO_32_BIT_CONVERSION = YES;
				GCC_WARN_ABOUT_RETURN_TYPE = YES_ERROR;
				GCC_WARN_UNDECLARED_SELECTOR = YES;
				GCC_WARN_UNINITIALIZED_AUTOS = YES_AGGRESSIVE;
				GCC_WARN_UNUSED_FUNCTION = YES;
				GCC_WARN_UNUSED_VARIABLE = YES;
				MACOSX_DEPLOYMENT_TARGET = 13.0;
				MTL_ENABLE_DEBUG_INFO = NO;
				MTL_FAST_MATH = YES;
				SDKROOT = macosx;
				SWIFT_COMPILATION_MODE = wholemodule;
				SWIFT_OPTIMIZATION_LEVEL = "-O";
			};
			name = Release;
		};
		AF000001000000000000001 /* Debug */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_ENTITLEMENTS = "";
				CODE_SIGN_IDENTITY = "-";
				CODE_SIGN_STYLE = Automatic;
				COMBINE_HIDPI_IMAGES = YES;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_TEAM = "";
				ENABLE_HARDENED_RUNTIME = YES;
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = PhoneHasher/Info.plist;
				INFOPLIST_KEY_NSHumanReadableCopyright = "Copyright © 2026. All rights reserved.";
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/../Frameworks",
				);
				MACOSX_DEPLOYMENT_TARGET = 13.0;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.phonehash.app;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
			};
			name = Debug;
		};
		B0000001000000000000001 /* Release */ = {
			isa = XCBuildConfiguration;
			buildSettings = {
				ASSETCATALOG_COMPILER_APPICON_NAME = AppIcon;
				ASSETCATALOG_COMPILER_GLOBAL_ACCENT_COLOR_NAME = AccentColor;
				CODE_SIGN_ENTITLEMENTS = "";
				CODE_SIGN_IDENTITY = "-";
				CODE_SIGN_STYLE = Automatic;
				COMBINE_HIDPI_IMAGES = YES;
				CURRENT_PROJECT_VERSION = 1;
				DEVELOPMENT_TEAM = "";
				ENABLE_HARDENED_RUNTIME = YES;
				ENABLE_PREVIEWS = YES;
				GENERATE_INFOPLIST_FILE = NO;
				INFOPLIST_FILE = PhoneHasher/Info.plist;
				INFOPLIST_KEY_NSHumanReadableCopyright = "Copyright © 2026. All rights reserved.";
				LD_RUNPATH_SEARCH_PATHS = (
					"$(inherited)",
					"@executable_path/../Frameworks",
				);
				MACOSX_DEPLOYMENT_TARGET = 13.0;
				MARKETING_VERSION = 1.0;
				PRODUCT_BUNDLE_IDENTIFIER = com.phonehash.app;
				PRODUCT_NAME = "$(TARGET_NAME)";
				SWIFT_EMIT_LOC_STRINGS = YES;
				SWIFT_VERSION = 5.0;
			};
			name = Release;
		};
/* End XCBuildConfiguration section */

/* Begin XCConfigurationList section */
		A8000001000000000000001 /* Build configuration list for PBXNativeTarget "PhoneHasher" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				AF000001000000000000001 /* Debug */,
				B0000001000000000000001 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
		AC000001000000000000001 /* Build configuration list for PBXProject "PhoneHasher" */ = {
			isa = XCConfigurationList;
			buildConfigurations = (
				AD000001000000000000001 /* Debug */,
				AE000001000000000000001 /* Release */,
			);
			defaultConfigurationIsVisible = 0;
			defaultConfigurationName = Release;
		};
/* End XCConfigurationList section */
	};
	rootObject = AB000001000000000000001 /* Project object */;
}
PBXPROJ

echo -e "${GREEN}✓ Xcode project created${NC}"
echo ""

echo -e "${BLUE}Step 3: Building the app with xcodebuild...${NC}"

# Clean previous builds
rm -rf "$DERIVED_DATA"

# Build the app
xcodebuild \
    -project "$PROJECT_DIR/$APP_NAME.xcodeproj" \
    -scheme "$APP_NAME" \
    -configuration Release \
    -derivedDataPath "$DERIVED_DATA" \
    CODE_SIGN_IDENTITY="-" \
    CODE_SIGNING_REQUIRED=NO \
    CODE_SIGNING_ALLOWED=NO \
    build

if [ $? -ne 0 ]; then
    echo "❌ Build failed"
    exit 1
fi

echo -e "${GREEN}✓ Build successful${NC}"
echo ""

echo -e "${BLUE}Step 4: Locating built app...${NC}"

# Find the built app
BUILT_APP=$(find "$DERIVED_DATA" -name "PhoneHasher.app" -type d | head -n 1)

if [ -z "$BUILT_APP" ]; then
    echo "❌ Could not find built app"
    exit 1
fi

echo -e "${GREEN}✓ Found app at: $BUILT_APP${NC}"
echo ""

echo -e "${BLUE}Step 5: Creating distribution package...${NC}"

# Create distribution directory
DIST_DIR="$PROJECT_DIR/dist"
rm -rf "$DIST_DIR"
mkdir -p "$DIST_DIR"

# Copy the app
cp -R "$BUILT_APP" "$DIST_DIR/"

# Remove quarantine attributes
xattr -cr "$DIST_DIR/PhoneHasher.app"

# Copy INSTALL.command if it exists
if [ -f "$PROJECT_DIR/INSTALL.command" ]; then
    cp "$PROJECT_DIR/INSTALL.command" "$DIST_DIR/"
    chmod +x "$DIST_DIR/INSTALL.command"
fi

# Create README
cat > "$DIST_DIR/README.txt" << 'EOF'
PhoneHasher - Installation Instructions

========================================
EASIEST METHOD (Recommended):
========================================
Double-click INSTALL.command
- Automatically removes security blocks
- Opens the app for you
- No manual steps needed!

========================================
ALTERNATIVE METHODS:
========================================

Method 1: Terminal Command
Open Terminal and run:
  xattr -cr ~/Downloads/PhoneHasher.app && open ~/Downloads/PhoneHasher.app

Method 2: Right-Click
- Right-click PhoneHasher.app
- Click "Open"
- Click "Open" in the dialog

Method 3: System Settings
- Try to open app (will be blocked)
- Go to System Settings → Privacy & Security
- Click "Open Anyway"
- Click "Open"

========================================
USAGE:
========================================
1. Select hash format from dropdown
2. Browse for CSV file with phone numbers
3. Click "PROCESS FILE"
4. Save the output
5. Done!

The app is completely safe and runs offline.
Security warnings are because it's not code-signed (requires $99/year Apple Developer account).

---
PhoneHasher v1.0
Copyright © 2026
EOF

# Get app size
APP_SIZE=$(du -sh "$DIST_DIR/PhoneHasher.app" | cut -f1)

echo -e "${GREEN}✓ Distribution package created${NC}"
echo ""

echo -e "${BLUE}Step 6: Creating ZIP file...${NC}"

# Create ZIP
cd "$DIST_DIR"
if [ -f "INSTALL.command" ]; then
    zip -ry PhoneHasher-Swift.zip PhoneHasher.app INSTALL.command README.txt
else
    zip -ry PhoneHasher-Swift.zip PhoneHasher.app README.txt
fi
cd "$PROJECT_DIR"

ZIP_SIZE=$(du -sh "$DIST_DIR/PhoneHasher-Swift.zip" | cut -f1)

echo -e "${GREEN}✓ ZIP created${NC}"
echo ""

echo "=========================================="
echo -e "${GREEN}✅ BUILD COMPLETE!${NC}"
echo "=========================================="
echo ""
echo "📦 Distribution Files:"
echo "   App:  $DIST_DIR/PhoneHasher.app ($APP_SIZE)"
echo "   ZIP:  $DIST_DIR/PhoneHasher-Swift.zip ($ZIP_SIZE)"
echo ""
echo "🚀 Next Steps:"
echo "   1. Test the app:"
echo "      open \"$DIST_DIR/PhoneHasher.app\""
echo ""
echo "   2. Share with team:"
echo "      Upload PhoneHasher-Swift.zip to Google Drive"
echo ""
echo "   3. Clean up build files (optional):"
echo "      rm -rf \"$DERIVED_DATA\""
echo "      rm -rf \"$PROJECT_DIR/$APP_NAME.xcodeproj\""
echo "      rm -rf \"$PROJECT_DIR/$APP_NAME\""
echo ""
echo "=========================================="
