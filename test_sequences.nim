# Running unittest with ./sequeces file
import unittest
import ./sequences # Import the modified sequences.nim

let expectedOutput = """Fruits: @["apricot", "banana", "cherry"]
We got: 3 fruits!
We have bananas!
Fruits: @["apricot", "cherry"]
Now we got: 2 fruits!
Foo
Bar
Baz
Lorem
4 2 23 25 123
""" # Added a newline at the end to match the output of getSequenceOutput()

let actualOutput = sequences.getSequenceOutput()

test "sequences.nim output":
  check actualOutput == expectedOutput

