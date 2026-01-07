import unittest, strutils

# --- SUITE 1: Logic for Age ---
suite "User Age Validation":
  setup:
    # This proc is only "visible" to tests in this suite
    proc validateAge(input: string): int =
      let age = parseInt(input)
      if age < 0 or age > 120:
        raise newException(ValueError, "Age out of range")
      return age

  teardown:
    echo "Finished an Age test case."

  test "accepts valid age boundaries":
    check validateAge("0") == 0
    check validateAge("120") == 120

# --- SUITE 2: Logic for Names ---
suite "User Name Validation":
  setup:
    # A different setup for a different set of tests
    proc validateName(name: string) =
      if name.len < 2:
        raise newException(ValueError, "Name too short")

  teardown:
    echo "Finished a Name test case."

  test "rejects short names":
    expect ValueError:
      validateName("A")
