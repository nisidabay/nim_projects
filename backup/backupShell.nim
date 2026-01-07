# Nim - backup utility
#
# Uses execCmdEx
import os, osproc, times, strformat

proc validateSource(dir, backupDir: string) =
  if not dirExists(dir):
    echo "Error: Source directory not found: " & dir
    quit(1)
  if not dirExists(backupDir):
    createDir(backupDir)

proc createTarCommand(dir, backupDir: string) =
  let timestamp = now().format("yyyy'-'MM'-'dd'_'HH'-'mm'-'ss")
  let backupFileName = joinPath(backupDir, fmt"backup_{timestamp}.tar.gz")
  let command = "tar -czf " & quoteShell(backupFileName) & " " & quoteShell(dir)

  echo "Backing up " & dir & " to " & backupFileName
  let (output, exitCode) = execCmdEx(command)

  if exitCode == 0:
    echo "Backup completed successfully!"
    echo "Backup file: " & backupFileName
  else:
    echo "Error: Backup failed with exit code " & $exitCode
    echo "Output:"
    echo output
    quit(exitCode)

proc backupDirectory(dir, backupDir: string) =
  createTarCommand(dir, backupDir)

when isMainModule:
  echo "Enter the source directory to backup: "
  let directoryToBackup = readLine(stdin)

  echo "Enter the destination backup directory: "
  let backupDestDir = readLine(stdin)

  validateSource(directoryToBackup, backupDestDir)
  backupDirectory(directoryToBackup, backupDestDir)
