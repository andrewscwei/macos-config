# iTerm Configuration

> Build 3.4.15

## Fonts

1. In `files/fonts/`, double-click any font and select **Install Font**
2. In iTerm, go to **Preferences** > **Profiles** > **Text**, then change the font

## Preferences Setup

* leave default

### General

1. Startup
    1. **Window restoration policy**: Use System Window Restoration Setting
    2. [ ] Open profiles window
2. Closing
    1. [ ] Quit when all windows are closed
    2. [ ] Confirm closing multiple sessions
    3. [ ] Confirm "Quit iTerm2 (⌘Q)
3. Magic*
4. Services*
5. Selection
    1. [x] Copy to pasteboard on selection
    2. [ ] Copied text includes trailing newline
    3. [ ] Applications in terminal may access clipboard
    4. [x] Triple-click selects entire wrapped lines
    5. [ ] Double-click performs smart seletion
    6. [x] Automatically enter copy mode on Shift+Arrow key with selection
    7. **Characters considered part of a word**: /-+\~_.
6. Window
    1. [ ] Smart window placement
    2. [x] Adjust window when changing font size
    3. [ ] Zoom maximizes vertically only
    4. [x] Native full screen windows
    5. [x] Separate window title per tab
7. Preferences*
8. tmux*

### Appearance

1. General
    1. **Theme**: Minimal
    2. **Tab bar location**: Top
    3. **Status bar location**: Top
    4. [x] Auto-hide menu bar in non-native fullscreen
    5. [ ] Exclude from Dock and ⌘-Tab Application Switcher
2. Windows
    1. [ ] Show window number in title bar
    2. [ ] Show border around windows
    3. [x] Hide scrollbars
    4. [x] Disable transparency for fullscreen windows by default
    5. [ ] Show line under title bar when the tab bar is not visible
    6. [ ] Show proxy icon in window title bar
3. Tabs
    1. [ ] Show tab bar even when there is only one tab
    2. [ ] Preserve window size when tab bar shows or hides
    3. [x] Show tab numbers
    4. [x] Tabs have close buttons
    5. [x] Show activity indicator
    6. [x] Show new-output indicator
    7. [ ] Flash tab bar when switching tabs in fullscreen
    8. [x] Show tab bar in fullscreen
    9. [x] Stretches tabs to fill bar
    10. [ ] Support basic HTML tags in tab titles
4. Panes
    1. [ ] Show per-pane title bar with split panes
    2. [ ] Separate status bars per pane
    3. [x] Separate background images per pane
    4. **Side margins**: 5
    5. **Top & bottom margins**: 2
5. Dimming
    1. **Dimming amount**: 60
    2. [x] Dim inactive split panes
    3. [ ] Dim background windows
    4. [x] Dimming affects only text, not background

### Profiles

1. General
    1. **Working Directory**: Set to desired default working directory
2. Colors
    > In `files/colors/`, double-click any `.itermcolors` file to add a color preset to iTerm
    1. **Color Presets...**: Select desired color preset
3. Text
    1. **Cursor**: Underline, [x] Blinking cursor
    2. **Text Rendering**
        1. [x] Draw bold text in bold font
        2. [ ] Blinking text
        3. [x] Italic text
        4. **Use thin strokes for anti-aliased text**: On Retina Displays
        5. [x] Use built-in Powerline glyphs
4. Window
    1. **Settings for New Windows**
        1. **Columns**: 160
        2. **Rows**: 50
5. Terminal*
6. Session*
7. Keys
    1. General
    2. Key Mappings
        1. **Presets...** > **Natural Text Editing** > **Keep**
8. Advanced*
