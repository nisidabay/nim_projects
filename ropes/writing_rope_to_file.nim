# Nim - Writing rope to a file without converting it to string

import std/ropes, std/times

proc testRopes() =
  var csv = rope("id,name,timestamp\n")

  for i in 1..<1_000:
    csv.add rope($i & ",user_" & $i & "," & $now() & "\n")

  # Single conversion at the end
  writeFile("big.csv", $csv)

testRopes()
