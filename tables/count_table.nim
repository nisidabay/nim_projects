# Nim - toCounTable

import std/[tables, strformat]

# Example-1
let myString = "abracadabra"
let letterFrequences = myString.toCountTable()

for k, v in letterFrequences:
  echo &"{k} = {v}"

# Example-2
var frequences = initCountTable[char]()
for c in myString:
  frequences.inc(c)

echo letterFrequences
