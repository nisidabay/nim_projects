# Nim - execProcess
# Executes a command and returns the full output(stdout+stderr) as string

import std/[osproc, strutils]

# The arguments must be passed via args
let files = execProcess("ls", args = ["-1"], options = {poUsePath})

if files.len == 0:
  echo "No files found or command failed."
else:
  for line in files.splitlines():
    if line.len > 0:
      echo "File found: ", line


let output = execProcess("git --version")
echo "version: ", output
