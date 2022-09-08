# macOS Keyboard Shortcuts

> For macOS Monterey, version 12.4

## Prerequisites

To configure macOS keyboard shortcuts from Terminal, you need to permit the Terminal app to have **Full Disk Access** permission:

1. **System Preferences** > **Security & Privacy** > **Privacy**
2. Go to **Full Disk Access**
3. Ensure the terminal app of choice is checked

## Importing Config

Install locally:

```sh
$ ./install.sh
```

After running the script, you need to restart the app for new keyboard shortcuts to take effect. You will also need to restart **Settings Preferences** app to see the newly defined keyboard shortcuts in **Keyboard** > **Shortcuts**.

## Defining Keyboard Shortcuts

To define keyboard shortcuts for an app, add the following to `install.sh`:

```sh
# install.sh

...

defaults write com.apple.universalaccess com.apple.custommenu.apps -array "<bundle_identifier0>" "<bundle_identifier1>" "<bundle_identifier2>"
defaults write <bundle_identifier0> NSUserKeyEquivalents '{
  "<menu_title>"="<key_code>";
}'
defaults write <bundle_identifier1> NSUserKeyEquivalents '{
  "<menu_title>"="<key_code>";
}'
defaults write <bundle_identifier2> NSUserKeyEquivalents '{
  "<menu_title>"="<key_code>";
}'
```

To find out the `<bundle_identifier>` of an app, run the following:

```sh
$ osascript -e 'id of app "App Name"'
```

The `<menu_title>` is the title of the menu item exactly as it appears.

To disable a keyboard shortcut, assign it to the zero-width space character `\U200b`.

## Key Codes

|Key        |Code    |Key        |Code    |
|-----------|--------|-----------|--------|
|Delete     |`\U007F`|Ctrl       |`^`     |
|Backspace  |`\U0008`|Shift      |`$`     |
|Tab        |`\U0009`|Option     |`~`     |
|Escape     |`\U001B`|Command    |`@`     |
|Enter      |`\U000A`|Numpad     |`#`     |
|Up Arrow   |`\UF700`|F1         |`\UF704`|
|Down Arrow |`\UF701`|F2         |`\UF705`|
|Left Arrow |`\UF702`|F3         |`\UF706`|
|Right Arrow|`\UF703`|...        |...     |
