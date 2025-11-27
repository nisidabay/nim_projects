# This file demonstrates how to recursively remove a directory and all its contents in Nim using the `os` module.
# It defines a `removeRecursive` procedure and includes an example of creating and then removing a directory structure.
# Remove directory recursively
import os

proc removeRecursive(dirPath: string) =
  for path in walkDir(dirPath):
    if isFile(path):
      removeFile(path)
    elif isDir(path):
      removeDir(path, recursive = true) # Calls the recursive os.removeDir

  removeDir(dirPath) # Now the top-level directory is empty and can be removed

let dirName = "my_other_dir"

# Create a non-empty directory for demonstration
if not dirExists(dirName):
  createDir(dirName)
  writeFile(joinPath(dirName, "fileA.txt"), "content A")
  createDir(joinPath(dirName, "subdirB"))
  writeFile(joinPath(dirName, "subdirB", "fileC.txt"), "content C")

# Call the custom recursive removal procedure
removeRecursive(dirName)

if not dirExists(dirName):
  echo "Directory '", dirName, "' and its contents have been removed."