# This file demonstrates the use of the `map` procedure from the `std/sequtils` module.
# It applies an anonymous procedure to each element of a sequence, transforming the numbers by doubling them.
# Use of map with anonymous procedure
import std/sequtils

# map example
let numbers = @[1, 2, 3, 4]
let doubled = numbers.map(proc(x: int): int = x * 2)
echo "Using map: ", doubled

proc doubledSeq(numbers: seq[int]): seq[int] =
  result = newSeq[int](numbers.len)
  for i, n in numbers:
    result[i] = n * 2

echo "Using imperative approach: ", doubledSeq(numbers)

