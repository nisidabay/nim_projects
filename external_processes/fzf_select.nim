# Use of execCmd with getTempDir to run find and fzf

import std/[os, osproc, strutils]

proc selectFile(): string =
  ## Integrates `find` and `fzf` by redirecting the selection to a temp file.
  let tmpFile = getTempDir() / "fzf_selection.txt"

  # Build a shell command that runs fzf and redirects the selection to a temp file.
  let cmd = "find . -type f | fzf > " & quoteShell(tmpFile)

  # execCmd runs the command in a shell and returns the exit code.
  let exitCode = execCmd(cmd)

  var selection = ""
  # Check if the file exists before trying to read it.
  if fileExists(tmpFile):
    selection = readFile(tmpFile).strip()
    removeFile(tmpFile) # Clean up the temp file.

  if exitCode == 0:
    return selection
  else:
    return ""

when isMainModule:
  echo "🚀 Launching interactive file selector..."
  let selectedFile = selectFile()

  if selectedFile.len > 0:
    echo "✅ You selected: ", selectedFile
  else:
    echo "❌ Selection cancelled."
