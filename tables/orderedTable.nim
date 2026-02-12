# Nim - OrderedTable
#
# Preserve the insertion order of keys
import std/tables

let
  a = [('z', 1), ('y', 2), ('x', 3)]
  ot = a.toOrderedTable

echo ot

