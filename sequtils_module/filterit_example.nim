# Nim - filterIt
import std/sequtils

let filterProc = proc(x: int): bool = x mod 2 == 0
let slice = @[1, 2, 3, 4, 5, 6]

echo slice.filterIt(it.filterProc)



