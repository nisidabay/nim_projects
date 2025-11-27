# This file demonstrates how to create a new directory in Nim using the `os`
# module. The `createDirectory` procedure takes a string (directory name) and
# creates the corresponding directory.
import os

proc createDirectory(dirName: string): void =
    createDir(dirName)

echo "Enter a dir name to create: "
let input = readLine(stdin)
createDirectory(input)
