use framework "CoreGraphics"

set input to { 0.0, 0.0, 1/2, 1.0 } -- left half
set input to { 1/4, 0.0, 1/2, 1.0 } -- center half
set input to { 1.0, 0.0, 1/2, 1.0 } -- right half
set input to { 0.0, 0.0, 1.0, 1/2 } -- top half
set input to { 0.0, 1/4, 1.0, 1/2 } -- mid half
set input to { 0.0, 1/2, 1.0, 1/2 } -- bottom half
set input to { 0.0, 0.0, 1/3, 1.0 } -- left thirds
set input to { 1/3, 0.0, 1/3, 1.0 } -- center thirds
set input to { 2/3, 0.0, 1/3, 1.0 } -- right thirds
set input to { 0.0, 0.0, 1.0, 1/3 } -- top thirds
set input to { 0.0, 1/3, 1.0, 1/3 } -- mid thirds
set input to { 0.0, 2/3, 1.0, 1/3 } -- bottom thirds
set input to { 0.0, 0.0, 1/4, 1.0 } -- left quarter
set input to { 1/4, 0.0, 1/4, 1.0 } -- center-left quarter
set input to { 1/2, 0.0, 1/4, 1.0 } -- center-right quarter
set input to { 3/4, 0.0, 1/4, 1.0 } -- right quarter
set input to { 0.0, 0.0, 1.0, 1/4 } -- top quarter
set input to { 0.0, 1/4, 1.0, 1/4 } -- mid-top quarter
set input to { 0.0, 2/4, 1.0, 1/4 } -- mid-bottom quarter
set input to { 0.0, 3/4, 1.0, 1/4 } -- bottom quarter
set input to { 0.0, 0.0, 1/3, 1/2 } -- 1/6
set input to { 1/3, 0.0, 1/3, 1/2 } -- 2/6
set input to { 2/3, 0.0, 1/3, 1/2 } -- 3/6
set input to { 0.0, 1/2, 1/3, 1/2 } -- 4/6
set input to { 1/3, 1/2, 1/3, 1/2 } -- 5/6
set input to { 2/3, 1/2, 1/3, 1/2 } -- 6/6
set input to { 0.0, 0.0, 1/4, 1/2 } -- 1/8
set input to { 1/4, 0.0, 1/4, 1/2 } -- 2/8
set input to { 1/2, 0.0, 1/4, 1/2 } -- 3/8
set input to { 3/4, 0.0, 1/4, 1/2 } -- 4/8
set input to { 0.0, 1/2, 1/4, 1/2 } -- 5/8
set input to { 1/4, 1/2, 1/4, 1/2 } -- 6/8
set input to { 1/2, 1/2, 1/4, 1/2 } -- 7/8
set input to { 3/4, 1/2, 1/4, 1/2 } -- 8/8
set input to { 0.0, 0.0, 1.0, 1.0 } -- fullscreen
set input to { (1 - 1/4)/2, (1 - 2/3)/2, 1/4, 2/3 } -- focused

tell application "System Events"
	-- Get the current active application.
	set activeApp to name of first application process whose frontmost is true

	-- Get x, y, width and height modifiers (0.0 - 1.0 inclusive) from input.
	set { x, y, w, h } to input

	-- Get x, y, width and height of the current display in which the active application is in.
	set { { vx, vy }, { vw, vh } } to current application's NSScreen's mainScreen's frame as list

	-- Apply modifiers to the position�and size of the current application window.
	tell process activeApp
		set position of first window to {vx + x*vw, vy + y*vh}
		set size of first window to {w*vw, h*vh}
	end tell
end tell
