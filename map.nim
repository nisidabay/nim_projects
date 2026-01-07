# Nim
#
# map function

import sequtils, strutils

# 1. Using an anonymous procedure
let numbers = @[1, 2, 3, 4, 5]

let doubled = map(numbers, proc(x: int): int = x * 2)
echo doubled
# Output: @[2, 4, 6, 8, 10]

let fruits = @["apple", "banana", "kiwi"]
let loudFruits = map(fruits, proc(s: string): string = s.toUpperAscii())

echo loudFruits
# Output: @["APPLE", "BANANA", "KIWI"]

# 2. Using a Named Procedure
proc addFive(n: int): int =
  result = n + 5

let numbersSeq1 = @[1, 10, 100]
let increased = map(numbersSeq1, addFive)
echo increased
# Output: @[6, 15, 105]

# Changing Data Types (Integers to Strings)
let numbersSeq2 = @[10, 20, 30]

let toStrings = map(numbersSeq2, proc(x: int): string = "Value: " & $x)

echo toStrings
# Output: @["Value: 10", "Value: 20", "Value: 30"]
