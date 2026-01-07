import os
import parseopt
import strutils

# Type to hold the arguments to parse
type
  Config = tuple
    filename: string
    mode: char

proc showHelp(filename: string, mode: char) =
  if mode == '\0' or filename == "":
    echo "Usage: rot13 -e|-d <filename>"
  return

# rot13 character shifting
proc rot13(input: string): string =
  for c in input:
    let base =
      if c >= 'a' and c <= 'z': 'a'.ord
      elif c >= 'A' and c <= 'Z': 'A'.ord
      else: -1

    if base != -1:
      let rotated = (c.ord - base + 13) mod 26 + base
      result.add(rotated.char)
    else:
      result.add(c)


# Parse command line arguments
proc parseArgs(): Config =
  var p = initOptParser()
  result.mode = '\0' # Set a default empty value

  for kind, key, val in p.getopt():
    case kind
    of cmdArgument:
      result.filename = key
    of cmdLongOption, cmdShortOption:
      if key == "e" or key == "encrypt":
        result.mode = 'e'
      elif key == "d" or key == "decrypt":
        result.mode = 'd'
    else:
      discard

# Saving an encrypted file
proc saveEncrypted(filename: string, content: string) =
  let newFilename = filename & ".enc"

  writeFile(newFilename, content)
  echo "File encrypted to: ", newFilename

  echo "Do you want to remove the original file? (y/n)"
  let answer = stdin.readLine()

  if answer == "y" or answer == "Y":
    removeFile(filename)
    echo "Original file removed."

# Saving a decrypted file
proc saveDecrypted(filename: string, content: string) =
  if filename.endsWith(".enc"):
    # Remove the last 4 characters (.enc)
    let newFilename = filename[0..^5]

    writeFile(newFilename, content)
    echo "File decrypted to: ", newFilename
    removeFile(filename)
  else:
    let newFilename = filename & ".dec"

    writeFile(newFilename, content)
    echo "File decrypted to: ", newFilename

# Entry point
proc main() =
  # Get the arguments first
  let (filename, mode) = parseArgs()

  # Validate inputs
  showHelp(filename, mode)

  if not fileExists(filename):
    echo "Error: File not found: ", filename
    quit(0)

  # Do the work
  let content = readFile(filename)
  let resultText = rot13(content)

  # Decide how to save based on the mode
  case mode
  of 'e':
    saveEncrypted(filename, resultText)
  of 'd':
    saveDecrypted(filename, resultText)
  else:
    discard

main()
