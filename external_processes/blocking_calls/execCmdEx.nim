# Nim execCmdEx
# Runs a command in the shell and returns the exit code

import std/[osproc, strutils]

# poUsePath ensures 'git' is found in system $poUsePath
let (output, code) = execCmdEx("git --version", options = {poUsePath})

if code == 0:
  echo "Detected Git Version: ", output.strip()
else:
  echo "Git checked failed"
