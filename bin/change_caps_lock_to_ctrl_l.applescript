tell application "System Settings"
	reveal pane "Keyboard"
	reveal anchor "CustomizeModifierKeys" of pane "Keyboard"
	get every anchor of current pane
end tell
tell application "System Events" to tell window 1 of process "System Settings"
	click button "Modifier Keys…" of tab group 1
  	repeat until (sheet 1) exists
		delay 0.1
	end repeat
	tell sheet 1
		tell pop up button 2
			click
			click menu item "⌃ Control" of menu 1
		end tell
		click button "OK"
	end tell
end tell
quit application "System Settings"
