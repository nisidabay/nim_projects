# map - apply a function to every item of the sequence

import std/sequtils

# map example with anonymous procedure
let numbers = @[1, 2, 3, 4]
let doubled = numbers.map(proc(x: int): int = x * 2)
echo "Using map: ", doubled

# Using and ad-hoc procedure to accomplish the same
proc doubledSeq(numbers: seq[int]): seq[int] =
  result = newSeq[int](numbers.len)
  for i, n in numbers:
    result[i] = n * 2

echo "Using imperative approach: ", doubledSeq(numbers)

