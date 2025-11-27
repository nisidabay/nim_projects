# This file demonstrates the use of variadic arguments (`varargs`) in Nim procedures.
# The `getHello` procedure accepts a variable number of string arguments and concatenates them into a single greeting message.
# Variadic arguments
proc getHello(names: varargs[string]): string =
  result = ""
  for name in names:
    result.add("Hello " & name & "\n")

let names = getHello("Carlos", "Alicia", "Sergio")
echo names