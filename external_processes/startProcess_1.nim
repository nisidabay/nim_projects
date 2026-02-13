# startProcess
# Best for run a shell command and interact with its output
# Writing to stdin, handling sterr separately, or managing
# background jobs

import std/[osproc, streams]

# args are passed as a sequence
let p = startProcess("ping", args = ["-c", "4", "8.8.8.8"],
options = {poUsePath})

# Access the output stream
let output = p.outputStream()
var line = ""

# Read while running or while data remains in buffer
while p.running or output.readLine(line):
  if line.len > 0:
    echo "🕐 Ping: ", line

p.close()
echo "Final Exit Code: ", p.peekExitCode()
