# Nim - Use of join
# Join items of sequence with a separator

import std/sequtils, strutils

var items: seq[string] = @[]
items.add(["Hello"])
items.add(["world", "!"])

var output = items.join(" ")

echo output

