# startProcess
#
# Backup script

import std/[osproc, os, strutils, terminal, streams]

proc getUserInput(): string =
  while true:
    stdout.write("Enter a directory to backup: ")
    stdout.flushFile()
    let input = readLine(stdin).strip()

    # Allow the user to return an empty string to signal "Quit"
    if input == "q" or input == "quit":
      return ""

    if input.len == 0:
      echo "No input provided. Please try again."
      continue

    let expandedPath = expandTilde(input)
    if not dirExists(expandedPath):
      styledEcho(fgRed, "Error: Directory '$1' not found." % expandedPath)
    else:
      return expandedPath

proc makeBackup(targetDir: string, backupName: string): bool =
  let p = startProcess("tar", args = ["--exclude", backupName, "-czf",
      backupName, targetDir], options = {poUsePath, poStdErrToStdOut})
  let output = p.outputStream().readAll()
  let exitCode = p.waitForExit()
  p.close()

  if exitCode != 0:
    styledEcho(fgRed, "Backup failed with exit code: $1" % $exitCode)
    # output tar command for debugging
    if output.len > 0:
      echo "Tar output:"
      echo output
    return false

  return true

proc main() =
  let targetDir = getUserInput()
  if targetDir.len == 0:
    quit("Backup cancelled.", 1)

  var backupFileName =
    if extractFilename(targetDir) == ".":
      extractFilename(getCurrentDir()) & ".tar.gz"
    else:
      extractFilename(targetDir) & ".tar.gz"

  echo "Backing up '$1' to '$2'..." % [targetDir, backupFileName]

  if makeBackup(targetDir, backupFileName):
    styledEcho(fgGreen, "Backup of directory '", targetDir,
        "' has been successfully created as '", backupFileName, "'")
  else:
    styledEcho(fgRed, "Backup operation failed.")

main()
