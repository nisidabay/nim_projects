# The primary purpose of this script is to provide a command-line interface for
# basic file system operations, similar to how shells like Bash or Zsh operate.
# It allows users to interact with their filesystem through simple commands
# while providing feedback on the actions performed and any errors that might
# occur.

import std/[rdstdin, strutils, os]

echo "🔒 Secure Admin Shell v1.0"
echo "   Commands: ls, cd <dir>, mkdir <name>, exit"

var line: string

# We dynamically update the prompt to show the current directory
# This requires a loop that allows line editing
while readLineFromStdin(getCurrentDir() & " $ ", line):
  let input = line.strip()
  if input.len == 0: continue

  let parts = input.splitWhitespace()
  let cmd = parts[0]

  try:
    case cmd
    of "exit", "quit":
      echo "👋 Session closed."
      break

    of "ls":
      # Lists files in current directory
      echo "   📂 Contents of ", getCurrentDir(), ":"
      for kind, path in walkDir(getCurrentDir()):
        # Just show the filename, not full path
        echo "      ", path.extractFilename()

    of "cd":
      if parts.len < 2:
        echo "   ❌ Usage: cd <directory>"
      else:
        # This is where rdstdin shines:
        # If the user types a long path and makes a typo,
        # they can use Left-Arrow to fix it.
        setCurrentDir(parts[1])

    of "mkdir":
      if parts.len < 2:
        echo "   ❌ Usage: mkdir <name>"
      else:
        createDir(parts[1])
        echo "   ✅ Created: ", parts[1]

    else:
      echo "   ❓ Unknown command: ", cmd

  except OSError as e:
    echo "   ❌ System Error: ", e.msg
