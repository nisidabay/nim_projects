# This file demonstrates the use of generics in Nim, specifically with the
# `showNumber` procedure that accepts both `int` and `float` types.

# Use of generics
proc showNumber(num: int | float) =
  echo(num)
showNumber(3.14)
showNumber(42)

proc showGeneric[T](num: T) =
  echo(num)
showGeneric(6.28)
showGeneric(24)
