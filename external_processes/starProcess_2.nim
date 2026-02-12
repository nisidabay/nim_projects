# startProcess
# Best for run a shell command and interact with its output
# Writing to stdin, handling sterr separately, or managing
# background jobs

import osproc

# Start a process: echo "Hello, Nim!"
var process = startProcess(
  command = "echo",
  workingDir = "",
  args = ["Hello, Nim!"],
  env = nil,
  options = {poStdErrToStdOut, poUsePath}
)

# Read output line-by-line using the iterator
for line in process.lines:
  echo "Received:", line

# Always close the process after use — critical!
process.close()
