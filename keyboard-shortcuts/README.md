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

#### `<bundle_identifier>`

To find out the `<bundle_identifier>` of an app, run the following:

```sh
$ osascript -e 'id of app "App Name"'
```

#### `<menu_title>`

The `<menu_title>` is the title of the menu item exactly as it appears. You can explicitly specify a submenu item but you must include all of its parent menu items all the way to the root. Wrap each parent menu item with `\033`, i.e. `\033View\033Group By\033Name`.

### Disabling a Shortcut

To disable a keyboard shortcut, assign it to the zero-width space character `\U200b`.

## Key Codes

|Key        |Code    |Key        |Code    |Key        |Code    |
|-----------|--------|-----------|--------|-----------|--------|
|Delete     |`\U007F`|Ctrl       |`^`     |F5         |`\UF708`|
|Backspace  |`\U0008`|Shift      |`$`     |F6         |`\UF709`|
|Tab        |`\U0009`|Option     |`~`     |F7         |`\UF70A`|
|Escape     |`\U001B`|Command    |`@`     |F8         |`\UF70B`|
|Enter      |`\U000A`|Numpad     |`#`     |F9         |`\UF70C`|
|Up Arrow   |`\UF700`|F1         |`\UF704`|F10        |`\UF70D`|
|Down Arrow |`\UF701`|F2         |`\UF705`|F11        |`\UF70E`|
|Left Arrow |`\UF702`|F3         |`\UF706`|F12        |`\UF70F`|
|Right Arrow|`\UF703`|F4         |`\UF707`|...        |...     |
