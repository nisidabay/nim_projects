# Nim
#
# This script calculates a large sum based on a loop and measures execution
# time. It demonstrates the need for appropriate data types to avoid overflow.

import std/[times, monotimes]

# A simple type to hold 2D coordinates.
# This is a value type, so it will be allocated on the stack for performance.
type Point = object
  x, y: int

# Calculates the squared Euclidean distance of a point from the origin.
# Returns a float to handle large values and prevent type mismatches.
# The `inline` pragma suggests the compiler insert the body of this proc
# directly at the call site, avoiding function call overhead.
proc dist(p: Point): float {.inline.} =
  let xf = p.x.float
  let yf = p.y.float
  return xf*xf + yf*yf

# Performs a batch computation, summing up the squared distances for points
# with coordinates from 1 to n.
# The return type is float to prevent integer overflow, which would occur
# with large 'n' if using standard integers.
proc computeBatch(n: int): float =
  var total: float = 0
  var p: Point
  for i in 1..n:
    p.x = i
    p.y = i
    # The `dist` proc is inlined here, so there is no function call overhead.
    total += dist(p)
  return total

when isMainModule:
  # Get a starting timestamp for performance measurement.
  let start = getMonoTime()

  # Run the computation with a large number of iterations.
  let result = computeBatch(100_000_000)

  # Print the final result and the total execution time.
  echo "Result: ", result
  echo "Time: ", (getMonoTime() - start)

