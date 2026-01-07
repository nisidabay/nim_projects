# Factorial in nim
proc factorial(n: int): int =
  result = 1
  for i in 1..n:
    result *= i
  # return result

echo factorial(5)

