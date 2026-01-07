# Nim
#
# unittest basic structure

import unittest

suite "Calculator Operations":
  # This is the "what" we are testing
  test "addition of positive numbers":
    # This is the "how" we check it
    check(2 + 2 == 4)
  
  test "multiplication by zero":
    # Even the obvious needs to be checked. Trust no one.
    check(5 * 0 == 0)
