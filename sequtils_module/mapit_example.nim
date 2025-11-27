# This file demonstrates the use of the `mapIt` macro from the `std/sequtils` module.
# It applies a transformation (converting each string to uppercase) to elements of a sequence using the implicit `it` variable.
# Use of mapIt
import std/sequtils, std/strutils

let words = @["nim", "rocks"]
let uppercased = words.mapIt(it.toUpperAscii())
echo uppercased