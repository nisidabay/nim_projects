# Nim
#
# Nim - Calculates and displays ticket prices for a list of people based on
# their age.

import strformat

type Person = object
  name: string
  age: int

func ticketPrice(p: Person): float =
  if p.age < 18: 10.0 else: 20.0

proc showPrices(people: seq[Person]) =
  for p in people:
    echo fmt"{p.name}: {ticketPrice(p)}"

when isMainModule:
  let group = @[
  Person(name: "Alice", age: 30),
  Person(name: "Bob", age: 12),
  Person(name: "Charlie", age: 61)
  ]
  showPrices(group)
