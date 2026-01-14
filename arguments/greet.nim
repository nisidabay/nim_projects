# Nim
#
# Generates a personalized greeting message with optional loud printing.


import os, strutils

proc showHelp() =
 echo "Usage: greet [name] [--loud]"
 echo " --loud  Print in uppercase"

proc main() =
 var name = "World"
 var loud = false
 var greeting = "Hello, " & name & "!"
 let args = commandLineParams()

 if args.len == 0 or "--help" in args or "-h" in args:
  showHelp()
  return

 for arg in args:
  if arg == "--loud":
   loud = true
  elif not arg.startsWith("-"):
   name = arg

 if loud:
  greeting = greeting.toUpperAscii()
 echo greeting

when isMainModule:
 main()

