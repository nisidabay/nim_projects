# Nim
#
# Generic test suite
import unittest, strutils

suite "User profile validation":
  setup:
    proc validateAge(input: string): int =
      let age = parseInt(input)

      if age < 0 or age > 120:
        raise newException(ValueError, "Age out of range")
      return age

  teardown:
    echo "Done"

  test "accepts valid age boundaries":
    let validAges = ["0", "18", "120"]

    for ageStr in validAges:
      let parsed = validateAge(ageStr)
      check parsed >= 0 and parsed <= 120

  test "rejects specific out-of-range numbers":
    let invalidAges = ["-1", "121", "999"]
    for ageStr in invalidAges:
      expect ValueError:
        discard validateAge(ageStr)
