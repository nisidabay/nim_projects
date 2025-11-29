import std/terminal
import std/strformat

# Note: The original code used arrow keys for navigation, but the required
# functions (readKey/getKey) could not be found during compilation.
# This version has been modified to use single key presses (1, 2, 3) for selection,
# which works reliably with the standard 'terminal' module.

const menuItems = ["Start service", "View logs", "Exit"]

proc renderMenu() =
  eraseScreen()
  setCursorPos(0, 0)
  echo "--- Terminal Menu ---"
  for i, item in menuItems:
    echo fmt"{i+1}. {item}"
  echo "Press a number to select an option."

proc run() =
  while true:
    renderMenu()
    let c = getch()
    case c
    of '1':
      eraseScreen()
      echo "Starting service..."
      break
    of '2':
      eraseScreen()
      echo "Viewing logs..."
      break
    of '3':
      break
    else:
      continue

run()

