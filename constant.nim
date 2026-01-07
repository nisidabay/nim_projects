# Declare a const in compilation time

proc fillString(): string =
  result = ""
  echo("Generating string")
  for i in 0..4:
    result.add($i) # Convers i to string

const count = fillString()
echo count

