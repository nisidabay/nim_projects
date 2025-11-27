# This file demonstrates various methods for returning values from procedures in Nim, including implicit returns, explicit `return` statements, and manipulation of the `result` variable.
# Values from procedures
proc implicit: string =
  "I will be returned"

proc discarded: string =
  discard "I will not be returned"

proc explicit: string =
  return "I will be returned"

proc resultVar: string =
  result = "I will be returned"

proc resultVar2: string =
  result = ""
  result.add("I will be ")
  result.add("returned")

# proc resultVar3: string =
#   result = "I a the result"
#   "I will cause an error"

assert implicit() == "I will be returned"
assert discarded() == ""
assert explicit() == "I will be returned"
assert resultVar() == "I will be returned"
assert resultVar2() == "I will be returned"