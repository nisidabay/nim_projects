import os
import parseopt
import strutils

# Type to hold the settings
type
  Config = tuple
    filename: string
    mode: char

proc showHelp(filename: string, mode: char) =
  if mode == '\0' or filename == "":
    echo "Usage: rot -e|-d <filename>"
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
proc getSettings(): Config =
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

# This handles the specific steps for saving an encrypted file.
proc saveEncrypted(filename: string, content: string) =
  let newFilename = filename & ".enc"
  writeFile(newFilename, content)
  echo "File encrypted to: ", newFilename

  echo "Do you want to remove the original file? (y/n)"
  let answer = stdin.readLine()
  if answer == "y" or answer == "Y":
    removeFile(filename)
    echo "Original file removed."

# This handles the specific steps for saving a decrypted file.
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

# This now acts like a manager, just calling the other workers.
proc main() =
  # Get the settings first
  let (filename, mode) = getSettings()

  # Validate inputs
  showHelp(filename, mode)

  if not fileExists(filename):
    echo "Error: File not found: ", filename
    return

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
