# This file demonstrates how to remove a directory and its contents in Nim
# using the `os.removeDir` procedure.

import os

let dirName = "my_dir"

# Create a non-empty directory for demonstration
if not dirExists(dirName):
  createDir(dirName)
  writeFile(joinPath(dirName, "file1.txt"), "some content")
  createDir(joinPath(dirName, "subdir"))
  writeFile(joinPath(dirName, "subdir", "file2.txt"), "more content")

# Recursively remove the directory
removeDir(dirName, checkDir = true)

if not dirExists(dirName):
  echo "Directory '", dirName, "' and its contents have been removed."

