# Nim  

# Create table from arrays

import std/tables
from std/sequtils import zip
from std/strformat import fmt

let
  names = ["John", "Paul", "George", "Ringo"]
  years = [1940, 1942, 1943, 1940]

var beatles = initTable[string, int]()

for pairs in zip(names, years):
  let (name, birthYear) = pairs
  beatles[name] = birthYear

echo fmt"The beatles are: {beatles}"


