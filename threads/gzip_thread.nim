# compile with these settings: nim c -r --threads:on --mm:orc script.nim
# For release: nim c -r -d:release --threads:on --mm:orc script.nim

import std/threadpool
import std/[os, osproc]

# Task object
type
  CompressTask = object
    filename: string

# The worker procedure
proc checkDependencies(dependency: string) =
  let exePath = findExe(dependency)
  if exePath == "":
    stderr.writeLine("Error: " & dependency & " not found")

# This runs inside the thread
proc compressFile(task: CompressTask) =
  # Validation: Ensure input file exists
  if not fileExists(task.filename):
    # We use stdout.writeLine instead of echo to be explicit about the stream
    stdout.writeLine("Skipping: ", task.filename, " (not found)")
    return


  # Construction:
  # quoteShell is crucial. It turns [file name.log] into ['file name.log']
  # so the command line doesn't break on spaces.
  let cmd = "gzip -k -f " & quoteShell(task.filename)

  # Feedback:
  echo "[Start] executing: " & cmd

  # Execution:
  # execCmd runs the system command and halts THIS thread until it finishes.
  # It returns 0 on success, or an error code (like 1 or 127) on failure.
  let exitCode = execCmd(cmd)

  if exitCode == 0:
    echo "[Done] Success: ", task.filename
  else:
    # We explicitly write errors to stderr so they don't get mixed with normal output
    stderr.writeLine("[Error] Failed with code " & $exitCode & ": " & task.filename)

when isMainModule:
  checkDependencies("gzip")
  let files = @["app1.log", "app2.log", "app3.log"]

  echo "Starting parallel compression..."

  for f in files:
    let task = CompressTask(filename: f)
    spawn compressFile(task)

  # Block the main process until all workers return
  sync()

  echo "---------------------------"
  echo "All tasks finished"

  # Verification (Optional): List the compressed files
  # 'discard' is used because execCmd returns an int, and we don't care about it here.
  discard execCmd("ls -lh *.gz")
