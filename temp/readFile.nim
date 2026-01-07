# Nim
#
# Read files/directorie

import strutils, os, terminal

proc readFile(name: string): string =
  let file = open(name, fmRead)
  defer: close(file)
  return file.readAll()

proc listFilesInDirectory(dir: string): seq[string] =
  result = @[]
  # Use walkDirRec for efficient, built-in recursive traversal.
  for path in walkDirRec(dir):
    # walkDirRec yields both files and directories, so we check.
    if not dirExists(path):
      result.add(path)

proc getFile(): void =
  stdout.styledWrite(fgBlue, styleDim, "Enter file or directory to read: ",
  resetStyle)
  let input = readLine(stdin).strip()

  if len(input) == 0:
    stdout.styledWrite(fgRed, styleDim, "No filename provided\n", resetStyle)
    return

  if dirExists(input):
    echo "Directory detected. Listing files..."
    let files = listFilesInDirectory(input)
    for file in files:
      echo file
    return

  # Check if the input is a file
  if not fileExists(input):
    stdout.styledWrite(fgRed, styleDim, "File does not exists\n", resetStyle)
    return

  try:
    let contents = readFile(input)
    stdout.write(contents)
    stdout.flushFile()
  except IOError as e:
    stdout.styledWrite(fgRed, styleBright, "Could not read: $(e.msg)", resetStyle)

when isMainModule:
  getFile()
