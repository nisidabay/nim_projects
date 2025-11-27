let numbers = @[1, 2, 3, 4, 5, 6]

# proc helper(x: int): bool =
#   result = x mod 2 == 0

# The higher-order function (accepting a 'helper' proc)
proc highOrder(numbers: seq[int], helper: (proc(x: int): bool)): seq[string] =
  result = @[]

  for number in numbers:
    # It calls whichever 'helper' proc it was given
    if helper(number):
      result.add($number & " is even")
    else:
      result.add($number & " is odd")

# Print the results
proc printResult(result: seq[string]) =
  for line in result:
    echo line

# The call using the 'proc' lambda
when isMainModule:
  printResult(highOrder(numbers, proc(x: int): bool =
    result = x mod 2 == 0
  ))
