# Example of a template in Nim


# A generic procedure to create a tuple of two elements
template makePair(a, b: untyped): untyped =
  (a, b)

# Usage
var p1 = makePair(1, 2)
echo "p1: " & $(p1)

var p2 = makePair("hello", "world")
echo "p2: " & $(p2)
