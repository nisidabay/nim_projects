
type
  FactorialError = ref object of ValueError
    n: int64

proc check(n: int64) =
  if n < 0:
    raise FactorialError(n: n, msg: "Factorial is not defined for negative numbers.")
  elif n > 20:
    raise FactorialError(n: n, msg: "Factorial of numbers greater than 20 will overflow an int64.")

proc factorial(n: int64): int64 =
  check(n)
  if n == 0:
    return 1
  result = 1
  for i in 2..n:
    result *= i
  return result

try:
  echo "Factorial of 5: ", factorial(5)
except FactorialError as e:
  echo "Error: ", e.msg

try:
  echo "Factorial of 0: ", factorial(0)
except FactorialError as e:
  echo "Error: ", e.msg

try:
  echo "Factorial of -1: "
  echo factorial(-1)
except FactorialError as e:
  echo e.msg

try:
  echo "Factorial of 21: "
  echo factorial(21)
except FactorialError as e:
  echo e.msg

