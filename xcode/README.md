# Xcode

Custom Xcode configuration—simply run the install script and you're good to go.

## Usage

### Download Xcode

Download/Update Xcode from the Apple Developer Portal (more reliable compared to downloading from the macOS App Store):

1. Sign in to https://developer.apple.com/
2. Go to **Downloads** > **Applications**
3. Find **Xcode** and download it

### Installing Config

Install via cURL:

```sh
curl -o- -s https://raw.githubusercontent.com/andrewscwei/macos-config/master/xcode/install.sh | bash
```

Relaunch Xcode and go to **Preferences**:

1. Go to **Key Bindings** and change **Key Binding Set** to *Custom*
2. Go to **Fonts and Colors** and select your favorite theme

### Exporting Config

```sh
./export.sh
```
