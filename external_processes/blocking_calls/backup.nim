# Nim - execCmd
# Best for: One-shot scripts where the user must see output immediately

import std/[osproc, os, strformat, strutils]

proc backup(source: string, dest: string) =
  var target = ""

  if source.startsWith("~"):
    target = expandTilde(source)
  elif source.startsWith("."):
    target = getCurrentDir()
  else:
    target = getEnv("HOME") & "/" & $source


  let code = execCmd(fmt"tar -czf {dest}.tar.gz " & quoteShell(target))
  let debug = false

  if debug:
    echo "Target: ", $target
    echo "Dest ", $dest

  if code != 0:
    quit "Backup failed with exit code: " & $code


# backup("~/r_nim_projects", "caca")
# backup("temp", "caca")
# backup(".", "caca")
