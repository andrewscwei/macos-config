# macOS Keyboard Shortcuts

> For macOS Monterey, version 12.4

## Prerequisites

To configure macOS keyboard shortcuts from Terminal, you need to permit the Terminal app to have **Full Disk Access** permission:

1. **System Preferences** > **Security & Privacy**
2. Go to **Full Disk Access**
3. Ensure the terminal app of choice is checked

## Importing Config

Install locally:

```sh
$ ./install.sh
```

To check the bundle identifier of a macOS app:

```sh
$ osascript -e 'id of app "App Name"'
```
