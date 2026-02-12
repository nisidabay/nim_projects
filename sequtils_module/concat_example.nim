# Nim - Use of concat
# concat is a function that combines multiple sequences into one. It's commonly
# used to join lists, arrays, or any sequence types.

import std/sequtils

# Example-1
let list1 = @["apple", "banana"]
let list2 = @["cherry", "date"]

let combined = concat(list1, list2)
echo combined

# Example-2
let s1 = "Hello"
let s2 = "World"

let flattened = concat(s1.toSeq(), s2.toSeq())
echo flattened

# Example-3
let range1 = 0..2
let range2 = 3..4

let result = concat(range1.toSeq, range2.toSeq)
echo result


# Example-4
proc joinRanges(ranges: seq[seq[int]]): seq[int] =
  result = ranges.concat()

let nums = joinRanges(@[@[1, 2, 3], @[4, 5, 6]])
echo nums

