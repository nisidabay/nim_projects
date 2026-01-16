import std/tables

var groupped = initTable[char, seq[string]]()
let names = ["Alice", "Bob", "Charlie", "Anna", "Ben"]

for name in names:
  groupped.mgetOrPut(name[0]).add(name)

echo groupped

