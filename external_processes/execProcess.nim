# execProcess
# Only the standard output is required

import std/[osproc, strutils]

# The arguments must be passed via args
let result = execProcess("ls", args = ["-1"], options = {poUsePath})

if result.len == 0:
  echo "No files found or command failed."
else:
  for line in result.splitlines():
    if line.len > 0:
      echo "File found: ", line

