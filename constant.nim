# This file demonstrates how to declare a compile-time constant in Nim, initialized by a procedure.
# Declare a const in compilation time

proc fillString(): string =
  result = ""
  echo("Generating string")
  for i in 0..4:
    result.add($i) # Convers i to string

const count = fillString()
echo count

