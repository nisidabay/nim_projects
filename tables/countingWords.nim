# Nim - use of mgetOrPut, CountTable

import std/tables

var counts = initTable[string, int]()
let words = ["apple", "banana", "apple", "cherry", "banana", "apple"]

for word in words:
  counts.mgetOrPut(word, 0) += 1

echo counts
echo words.toCountTable.largest
echo words.toCountTable.smallest
