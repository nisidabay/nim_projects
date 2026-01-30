
import os # Needed for removeFile

proc createGreetingFile(path: string) =
  var file: File # file descriptor

  if open(file, path, fmWrite):
    try:
      file.writeLine("Hello from Nim!")
      file.writeLine("File operations made simple.")
      echo " ✔️Written to: ", path
    finally:
      file.close()
  else:
    raise newException(IOError, "Cannot create file: " & path)

when isMainModule:
  let target = "greeting.txt"
  createGreetingFile(target)
  echo readFile(target)
  removeFile(target)
