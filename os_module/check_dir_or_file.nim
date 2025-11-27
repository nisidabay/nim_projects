# This file demonstrates how to check if a given path refers to an existing
# file or directory using Nim's `os` module. The `checkFileDir` procedure takes
# a path as input and returns a string indicating whether the path is a file, a
# directory, or does not exist.

import os

proc checkFileDir(name: string): string =
  let path = name
  # Use the 'result' variable to set the return value for the proc.
  if fileExists(path):
    result = "File exists!"
  elif dirExists(path):
    result = "Dir exists!"
  else:
    result = "Nothing found with: " & path

echo "Enter a file/dir name to check: "
let input = readLine(stdin)
let found = checkFileDir(input)
echo found
