# Nim - backup utility
#
# Uses startProcess
import os, osproc, times, streams, strformat

proc createBackupPath(backupDir: string): string =
  let timestamp = now().format("yyyy'-'MM'-'dd'_'HH'-'mm'-'ss")
  result = joinPath(backupDir, fmt"backup_{timestamp}.tar.gz")

proc runTarBackup(sourceDir: string, backupFile: string) =
  echo "Backing up " & sourceDir & " to " & backupFile
  let args = ["-czf", backupFile, sourceDir]
  let p = startProcess("tar", "", args, nil, {poUsePath, poStdErrToStdOut})
  let output = p.outputStream.readAll()
  let exitCode = p.waitForExit()
  p.close()

  if exitCode != 0:
    let errorMsg = fmt"""
Error: Backup failed with exit code {exitCode}.
Output:
{output}
"""
    quit(errorMsg, 1)

proc run(sourceDir: string, backupDir: string) =
  if not dirExists(sourceDir):
    quit("Error: Source directory not found: " & sourceDir, 1)

  if not dirExists(backupDir):
    createDir(backupDir)

  let backupFile = createBackupPath(backupDir)
  runTarBackup(sourceDir, backupFile)

  echo "Backup completed successfully!"
  echo "Backup file: " & backupFile

when isMainModule:
  if paramCount() != 2:
    let scriptName = if paramCount() > 0: paramStr(0) else: "backupProcess"
    echo "Usage: " & scriptName & " <source_directory> <backup_directory>"
    quit(1)

  let sourceDir = paramStr(1)
  let backupDir = paramStr(2)
  run(sourceDir, backupDir)
