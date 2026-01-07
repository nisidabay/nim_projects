# Nim - walkDir function
#
# Count files and dirs in Home
import os

var countFiles = 0
var countDirs = 0

for kind, path in walkDir(expandTilde("~")):
  case kind
  of pcFile:
    discard
    countFiles += 1
  of pcDir:
    discard
    countDirs += 1
  else: discard

echo "--- Home stats ---"
echo "Total files: ", countFiles
echo "Total directories: ", countDirs
