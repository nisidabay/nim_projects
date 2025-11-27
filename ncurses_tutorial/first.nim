import ncurses
#[
Line-by-Line Explanation
import ncurses: This imports the Nim wrapper for the ncurses C library.

discard initscr(): This is the first ncurses function you must always call. It
sets up the terminal for ncurses mode and creates the stdscr. We use discard
because most ncurses functions return an integer (like OK or ERR), and Nim's
compiler will warn us if we don't handle or discard this return value.

discard mvprintw(10, 10, ...): This is one of the most common functions you'll
use. It stands for "move and print with format." It moves the virtual cursor to
the (y, x) coordinate (row 10, column 10) and prints the string.

discard refresh(): As explained above, this is the "paint" button that makes
our "Hello, world!" text actually appear on the screen.

discard getch(): This function "gets a character" from the user. It waits for a
single key press. We use it here to pause the program so we can see our text.

discard endwin(): This is the last function you must always call. It restores
your terminal to its normal operating mode. If you forget to call endwin(),
your terminal will be left in ncurses mode, and it will look broken (e.g.,
typing won't appear, your prompt will be gone). If this happens, type reset
blindly and press Enter to fix it.

]#
# 1. Initialize the ncurses screen
# This clears the screen and sets up the stdscr window.
discard initscr()

# 2. Print a string at a specific coordinate (y, x)
# NOTE: Coordinates are (row, column) or (y, x), NOT (x, y)!
discard mvprintw(10, 10, "Hello, world!")

# 3. Refresh the screen
# CRITICAL: Without this, your changes are only in the
# virtual screen and will not be shown to the user.
discard refresh()

# 4. Wait for a single key press
# This keeps our program alive until the user is ready to quit.
discard getch()

# 5. Shut down ncurses
# CRITICAL: This restores the terminal to its
# normal, usable state.
discard endwin()
