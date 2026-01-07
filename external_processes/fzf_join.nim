# Use of execCmdEx to run find and fzf

import std/[osproc, strutils]

proc selectFile(): string =
  ## Uses `execCmdEx` to join `find` and `fzf` with a shell pipe.
  let cmd = "find . -type f | fzf"

  # The key is using only the `poEvalCommand` option.
  # This evaluates the command in a shell (to handle the '|')
  let (output, exitCode) = execCmdEx(cmd, options = {poEvalCommand})

  if exitCode == 0:
    return output.strip()
  else:
    return ""

when isMainModule:
  echo "🚀 Launching interactive file selector via execCmdEx..."
  let selectedFile = selectFile()

  if selectedFile.len > 0:
    echo "✅ You selected: ", selectedFile
  else:
    echo "❌ Selection cancelled."
