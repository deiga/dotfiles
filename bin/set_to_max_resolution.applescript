-- Launch "System Preferences", open the "Displays" options and change to the "Display" tab
tell application "System Preferences"
	activate
	set the current pane to pane id "com.apple.preference.displays"
	reveal anchor "displaysDisplayTab" of pane id "com.apple.preference.displays"
end tell

-- Now lets make the necessary changes
tell application "System Events"
	tell application process "System Preferences"
		repeat until (tab group 1 of window 1) exists
			delay 0.1
		end repeat
		tell tab group 1 of window 1
			
			-- Click the "Scaled" radio button
			click radio button "Scaled"
			
			tell radio group of group 1
				-- Click the radio button for the new scale option/index
				click radio button 5 -- 1920 x 1200
			end tell
			
		end tell
	end tell
end tell

-- Quit "System Preferences"
quit application "System Preferences"
