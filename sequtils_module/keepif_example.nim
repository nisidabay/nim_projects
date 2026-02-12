# Nim - Use of keepIf

import std/sequtils

# Modified the list in place
var numbers: seq[int] = @[1, 2, 3, 4, 5, 6]
keepIf(numbers, proc(x: int): bool = x mod 2 == 0)
echo numbers
