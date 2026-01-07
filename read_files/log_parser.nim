import std/os, std/strutils

const LogName = "server.log"

# Setup: Generate a dummy log
writeFile(LogName, "INFO: Start\nERROR: Fail\nINFO: End")

try:
  # fmRead is the default mode
  let f = open(LogName, fmRead)

  # defer ensures f.close() is called when scope exits
  defer: f.close()

  var line: string
  var lineCount = 0

  # Reuses 'line' buffer for every iteration
  while f.readLine(line):
    lineCount += 1
    if line.startsWith("ERROR"):
      echo "🚩 Issue found on line ", lineCount, ": ", line

except IOError:
  echo "❌ Could not open log file."

# Cleanup
removeFile(LogName)
