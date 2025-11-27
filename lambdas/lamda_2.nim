# Lambda is an anonymous procedure define "inline"

let numbers = @[1, 2, 3, 4, 5, 6]

# The *new* flexible procedure
proc processNumbers(numbers: seq[int],
                    helper: (proc(x: int): bool),
                    trueStr: string,
                    falseStr: string): seq[string] =
  result = @[]

  for number in numbers:
    # It calls the helper lambda
    if helper(number):
      # It uses the 'trueStr' parameter
      result.add($number & trueStr)
    else:
      # It uses the 'falseStr' parameter
      result.add($number & falseStr)

# 3. The 'echo' procedure (unchanged)
proc printResult(result: seq[string]): void =
  for line in result:
    echo line

# 4. Calling the new procedure

echo "--- Checking for Odd/Even ---"
printResult(processNumbers(
  numbers,
  proc(x: int): bool = x mod 2 != 0, # Lambda 1
  " is odd", # trueStr
  " is even" # falseStr
))

echo "\n--- Checking for > 3 ---"
printResult(processNumbers(
  numbers,
  proc(x: int): bool = x > 3, # Lambda 2
  " is greater than 3", # trueStr
  " is not greater than 3" # falseStr
))
