# Nim
#
# Uniform function call syntax
proc plus(x, y: int): int =
  return x + y

proc multi(x, y: int): int =
  return x * y

let
  a = 2
  b = 3
  c = 4

echo a.plus(b) == plus(a, b)
echo c.multi(a) == multi(c, a)

echo a.plus(b).multi(c)
echo c.plus(b).multi(a)
