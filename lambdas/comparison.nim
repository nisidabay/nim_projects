# This script show different ways to filter odd numbers
import sequtils

# 1. Filter odd numbers using filter from sequtils
let numbers = @[1, 2, 3, 4, 11, 23, 42, 37]
let isOdd = numbers.filter(proc(x: int): bool = x mod 2 == 1)
echo "Using filter: ", isOdd

# 2. Using high-order function
# Named procedure
proc findOdd(number: int): bool =
  if number mod 2 == 1:
    return true
  else:
    return false

proc checkOdd(numbers: seq[int], helperProc: (proc(x: int): bool)): seq[int] =
  result = @[]
  for n in numbers:
    if helperProc(n) == true:
      result.add(n)

let oddNumbers_1 = checkOdd(numbers, findOdd)
echo "Using high-order function: ", oddNumbers_1

# 3. Using anonymous function (lambda)

proc checkLambda(numbers: seq[int], helperProc: proc(x: int): bool): seq[int] =
  result = @[]
  for n in numbers:
    if helperProc(n) == true:
      result.add(n)

let oddNumbers_2 = checkLambda(numbers, proc(x: int): bool =
  if x mod 2 == 1:
    return true
  else:
    return false
)
echo "Using lambda: ", oddNumbers_2

# 4. Using a normal procedure
proc keepOdds(a: seq[int]): seq[int] =
  result = @[]
  for number in a:
    if number mod 2 == 1:
      result.add(number)

echo "Using normal procedure: ", keepOdds(numbers)
