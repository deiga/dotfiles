tell application "System Events"
	do shell script "/System/Applications/Mission\\ Control.app/Contents/MacOS/Mission\\ Control"
	tell process "Dock"
		tell group "Mission Control"
			tell group 1
				tell group "Spaces Bar"
					
					-- set uiElems to entire contents
					
					set countSpaces to count (buttons whose name starts with "Desktop") of list 1
					if countSpaces < 5 then
						repeat until (count (buttons whose name starts with "Desktop") of list 1) = 5
							click button 1
						end repeat
					end if
					--new space
					--		click button 1 of group 1
					--switch to new space
					--		repeat until (count buttons of list 1 of group 1) = (countSpaces + 1)
					--		end repeat
					--		click button (countSpaces + 1) of list 1 of group 1
				end tell
			end tell
		end tell
	end tell
end tell


-- delay 0.5
--tell application "System Events" to click (every button whose value of attribute "AXDescription" is "add desktop") of group "Spaces Bar" of group 1 of group "Mission Control" of process "Dock"
--delay 0.5
--tell application "System Events" to click (every button whose value of attribute "AXDescription" is "add desktop") of group "Spaces Bar" of group 1 of group "Mission Control" of process "Dock"
--delay 0.5
--tell application "System Events" to click (every button whose value of attribute "AXDescription" is "add desktop") of group "Spaces Bar" of group 1 of group "Mission Control" of process "Dock"
--delay 0.5
--tell application "System Events" to click (every button whose value of attribute "AXDescription" is "add desktop") of group "Spaces Bar" of group 1 of group "Mission Control" of process "Dock"
--delay 0.5
do shell script "/System/Applications/Mission\\ Control.app/Contents/MacOS/Mission\\ Control 1"
