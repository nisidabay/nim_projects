# readLine - Robustly handles empty lines, exit commands, and system EOF
# signals.

import std/strutils

echo "🤖 EchoBot 1.0 (Type 'exit' to quit)"
echo "-----------------------------------"

var line: string

# 'readLine' returns false when EOF is reached (Ctrl+D)
while stdin.readLine(line):
  let cleanLine = line.strip()

  if cleanLine == "exit":
    echo "🤖 Shutting down..."
    break

  if cleanLine.len == 0:
    continue

  echo "🤖 You said: ", cleanLine.toUpperAscii()

echo "🛑 End of session."
