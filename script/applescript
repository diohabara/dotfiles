#!/usr/bin/osascript -e

-- hide Dock automatically
tell application "System Events" to set the autohide of the dock preferences to true

-- set capslock to be ctrl
tell application "System Preferences"
    activate
    set current pane to pane "com.apple.preference.keyboard"
end tell
tell application "System Events"
    tell process "System Preferences"
        click checkbox 1 of tab group 1 of window "Keyboard"
    end tell
end tell

-- enable three-finger drag
tell application "System Preferences"
    activate
    set current pane to pane "com.apple.preference.trackpad"
end tell
tell application "System Events"
    tell process "System Preferences"
        click checkbox 1 of tab group 1 of window "Trackpad"
        click radio button 2 of tab group 1 of window "Trackpad"
    end tell
end tell

-- disable Spotlight in "Keyboard shortcuts" in "System Preferences"
tell application "System Preferences"
    activate
    set current pane to pane "com.apple.preference.keyboard"
end tell
tell application "System Events"
    tell process "System Preferences"
        click button "Shortcuts" of tab group 1 of window "Keyboard"
        delay 0.5
        click checkbox 12 of row 1 of table 1 of scroll area 1 of tab group 1 of window "Keyboard"
    end tell
end tell

-- make "Key Repeat" and "Delay Until Repeat" fastest and shortest in "System Preferences" respectively
tell application "System Preferences"
    activate
    set current pane to pane "com.apple.preference.keyboard"
end tell
tell application "System Events"
    tell process "System Preferences"
        set value of slider 1 of tab group 1 of window "Keyboard" to 2
        set value of slider 2 of tab group 1 of window "Keyboard" to 0
    end tell
end tell
