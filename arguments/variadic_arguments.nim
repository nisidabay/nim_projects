# Nim
#
# variadic_arguments
import std/strutils

proc getHello(names: varargs[string]): string =
  result = "Hello "
  for name in names:
    result.add(name & ", ")

  # Replace the last "," with a "."
  let lastCommaPos = result.rfind(", ")
  if lastCommaPos != -1:
    result = result[0..<lastCommaPos] & "."

let names = getHello("Carlos", "Alicia", "Sergio")
echo names

