# This file demonstrates how to calculate the factorial of a number in Nim using a loop.
# Factorial in nim
proc factorial(n: int): int =
  result = 1
  for i in 1..n:
    result *= i # Explicit return
  # return result

echo factorial(5)

