# Nim
#
# Simple Terminal Menu in Nim

import std/[terminal, strformat]

const menuItems = @[
  "Start service",
  "View logs",
  "Exit"
]

proc renderMenu() =
  eraseScreen()
  echo "--- Terminal Menu ---\n"
  for i, item in menuItems:
    echo fmt"{i+1}. {item}\n"
  echo "\nEnter your choice: "

proc run() =
  while true:
    renderMenu()
    let choice = getch()

    case choice
    of '1':
      eraseScreen()
      echo "Starting service...\n"
      discard getch() # Wait for any key to continue
    of '2':
      eraseScreen()
      echo "Viewing logs...\n"
      discard getch()
    of '3':
      return # Exit the program
    else:
      echo "\nInvalid choice. Try again.\n"
      discard getch()

run()

