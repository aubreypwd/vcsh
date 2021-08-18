#!/bins/sh

/usr/local/bin/gittower ./

sleep 1

osascript -e 'tell application "System Events"
    tell process "Tower"
        set frontmost to true
        click menu item "Show History" of menu "View" of menu bar 1
    end tell
end tell'
