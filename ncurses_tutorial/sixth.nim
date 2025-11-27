import ncurses

# --- Initialization ---
let stdscr = initscr()
if stdscr == nil:
  echo "Failed to initialize ncurses."
  quit(1)

discard cbreak() # Get input instantly
discard noecho() # Don't echo typed keys
discard keypad(stdscr, true) # Enable arrow keys (KEY_UP, etc.)
discard curs_set(0) # Hide the physical terminal cursor

# --- Game Setup ---
# Get screen boundaries
var maxY, maxX: cint
getmaxyx(stdscr, maxY, maxX)

# Set initial player position (y, x)
# y and x will be inferred as cint, which is correct
var y = maxY div 2
var x = maxX div 2

# --- Game Loop ---
discard mvprintw(0, 0, "Use arrow keys to move. Press 'q' to quit.")
discard mvwprintw(stdscr, y, x, "@") # Draw player
discard refresh()

var ch: cint
while true:
  ch = getch() # Wait for input

  # --- Input Handling ---
  case ch
  of cint('q'.ord): # <-- FIX: Cast 'q'.ord from int to cint
    break # Exit loop
  of KEY_UP:
    if y > 0: y -= 1
  of KEY_DOWN:
    if y < maxY - 1: y += 1
  of KEY_LEFT:
    if x > 0: x -= 1
  of KEY_RIGHT:
    if x < maxX - 1: x += 1
  else:
    discard

  # --- Drawing ---
  discard clear() # Clear the *entire* virtual screen
  discard mvprintw(0, 0, "Use arrow keys to move. Press 'q' to quit.")
  discard mvwprintw(stdscr, y, x, "@") # Draw player at new position
  discard refresh() # Paint changes to physical screen

# --- Shutdown ---
discard curs_set(1) # Re-enable the cursor
discard endwin()

