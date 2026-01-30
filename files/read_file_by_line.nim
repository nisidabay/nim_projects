import os, strutils

proc countLinesAndWords(path: string): tuple[lines, words: int] =
  result = (0, 0)
  var file: File
  if open(file, path, fmRead):
    try:
      while not file.endOfFile():
        let line = file.readLine()
        result.lines += 1
        result.words += line.splitWhitespace().len
    finally:
      file.close()
  else:
    raise newException(IOError, "Cannot open: " & path)

when isMainModule:
  let testFile = "sample.txt"
  writeFile(testFile, "Nim is expressive\nand efficient\n")

  let stats = countLinesAndWords(testFile)
  echo "Lines: ", stats.lines
  echo "Words: ", stats.words

  removeFile(testFile)

