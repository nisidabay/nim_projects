# hash.sh.nim
import os, strutils, streams, osproc

proc hashFile(fname: string): string =
  if not fileExists(fname):
    return "NOT_FOUND"
  let p = startProcess("/usr/sbin/md5sum", args = @[fname])
  defer: p.close()
  discard p.waitForExit()
  result = p.outputStream.readAll().strip().split()[0]
  return result

when isMainModule:
  let files = @["/etc/passwd", "/bin/ls"]
  for f in files:
    echo f, " → ", hashFile(f)
