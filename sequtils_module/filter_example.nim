# Nim - Use of filter
import std/sequtils

let filteredSeq = filter([1, 2, 3, 4, 5, 6], proc(x: int): bool = x mod 2 == 0)
echo filteredSeq
