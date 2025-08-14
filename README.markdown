# Bunt

[![Build](https://github.com/zonble/bunt/actions/workflows/build.yml/badge.svg)](https://github.com/zonble/bunt/actions/workflows/build.yml)

## What is Bunt?

*Bunt* is a German word meaning colorful, and it is a modern, easy-to-use macOS application designed for Mac and iOS developers who work with colors. After picking a color from the system color picker, it instantly generates ready-to-use source code for your projects.

### Supported Frameworks

Bunt generates code for all major Apple development frameworks:

* **NSColor** - for macOS Cocoa framework applications
* **UIColor** - for iOS/iPadOS UIKit framework applications  
* **CGColor** - for Core Graphics and Quartz 2D drawing
* **OpenGL** - supports glColor3f(), glColor3fv(), glColor4f() and glColor4fv() functions

## System Requirements

### For Users
* macOS 11.0 (Big Sur) or later

### For Development
* macOS 11.0 (Big Sur) or later
* Xcode (latest version recommended)
* Command Line Tools for Xcode

## Installation

Download the latest release from the [Releases](https://github.com/zonble/bunt/releases) page, or build from source following the development instructions below.

## Development

### Building from Source

1. Clone the repository:
   ```bash
   git clone https://github.com/zonble/bunt.git
   cd bunt
   ```

2. Open the project in Xcode:
   ```bash
   open Bunt.xcodeproj
   ```

3. Build and run the project using Xcode, or build from the command line:
   ```bash
   xcodebuild -project Bunt.xcodeproj -target Bunt -configuration Release
   ```

### Contributing

This project welcomes contributions! The codebase has been modernized for current macOS development practices. Please ensure your changes:
- Maintain compatibility with macOS 11.0+
- Follow the existing code style
- Include appropriate documentation updates

## Feedback & Contact

Any suggestions or advice are welcome! Please:
- Open an issue on [GitHub Issues](https://github.com/zonble/bunt/issues)
- Contact the maintainer at zonble@gmail.com

## References

* [NSColor Reference](https://developer.apple.com/documentation/appkit/nscolor) on Apple Developer Documentation
* [UIColor Reference](https://developer.apple.com/documentation/uikit/uicolor) on Apple Developer Documentation  
* [Core Graphics Documentation](https://developer.apple.com/documentation/coregraphics) on Apple Developer Documentation
* [OpenGL Color Functions](https://registry.khronos.org/OpenGL-Refpages/gl2.1/xhtml/glColor.xml) on Khronos OpenGL Registry
