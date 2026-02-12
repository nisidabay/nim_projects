# Nim - Use of mapIt
import std/[sequtils, strutils]

# Example 1
let words = @["nim", "rocks"]
let uppercased = words.mapIt(it.toUpperAscii())
echo uppercased

# Example 2
let numbers = @[1, 2, 3, 4]
let makeDouble = proc(x: int): int = x * 2
let doubled = numbers.mapIt(it.makeDouble)
echo doubled

# Example 3
let result = ["10", "20"].mapIt(parseInt(it))
echo result

