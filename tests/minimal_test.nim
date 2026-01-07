# Nim
#
# Running a minimal test
import unittest

let result = 5 + 5
test "Addition works correctly":
  check result == 10
  check result > 5
