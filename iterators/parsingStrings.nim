# This script defines an iterator named `parseNums` that takes an openArray of
# strings and yields integer values. If parsing a string fails (due to a
# `ValueError`), it yields zero instead. The main part of the script initializes
# some raw data as an array of strings, then iterates over this data using the
# `parseNums` iterator to parse each string into an integer. For any string that
# cannot be parsed into an integer, it defaults to zero. Finally, it multiplies
# each parsed number by 2 and prints the result.

import std/strutils
import std/sequtils

iterator parseNums[T, U](strings: openArray[T]): U =
  for s in strings:
    try:
      yield parseInt(s)
    except ValueError:
      yield 0

let rawData = ["10", "20", "oops", "40"]
let rawData_2 = ["1", "2", "3"]

# Concatenate rawData and rawData_2 into a single sequence
let combinedData = rawData.toSeq & rawData_2.toSeq

for n in parseNums[string, int](combinedData):
  echo n * 2
