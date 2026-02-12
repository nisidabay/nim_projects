# Nim - Group tables by key

import std/tables
from std/sequtils import zip

let
  names = ["John", "Paul", "George", "Ringo"]
  years = [1940, 1942, 1943, 1940]

var beatlesByYear = initTable[int, seq[string]]()

for pairs in zip(years, names):
  let (birthYear, name) = pairs

  if not beatlesByYear.hasKey(birthYear):
  # Initialize the Table
    beatlesByYear[birthYear] = @[]
  beatlesByYear[birthYear].add(name)

echo beatlesByYear
