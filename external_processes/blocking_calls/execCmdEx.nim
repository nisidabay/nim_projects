# Nim execCmdEx
# Capture OutPut and Exit code

import std/[osproc, strutils]

# poUsePath ensures 'git' is found in system $poUsePath
let (outTxt, code) = execCmdEx("git --version", options = {poUsePath})

if code == 0:
  echo "Detected Git Version: ", outTxt.strip()
else:
  echo "Git checked failed"

