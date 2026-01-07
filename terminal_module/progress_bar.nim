#  bar.nim  →  nim r bar.nim
import std/[terminal, os, strutils, strformat]

proc fg256(colorCode: int): string =
  ## Returns the ANSI escape code for a 256-color foreground.
  ## `colorCode` should be between 0 and 255.
  result = "\x1b[38;5;" & $colorCode & "m"

proc progress(pc: int) =
  let (cols, _) = terminalSize()
  let w = max(20, cols - 15)
  let fill = int(w * pc / 100)
  stdout.setCursorPos(0, 0)
  stdout.eraseLine()
  stdout.write fg256(34) # green (color code 34)
  stdout.write repeat("█", fill)
  stdout.write fg256(240) # gray
  stdout.write repeat("░", w - fill)
  stdout.resetAttributes()
  stdout.write &" {pc:3}%"

for i in 0..100:
  progress(i)
  sleep(20)
echo()
