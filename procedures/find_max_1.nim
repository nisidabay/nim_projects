# Nim
#
# Find the maximun of two numbers

import strutils

proc findMax(x: int, y: int): int =
  result = if x > y: x else: y


proc inputMessage(msg: string) =
    stdout.write(msg)
    stdout.flushFile()

proc parseInput(): int =
  let temp = stdin.readLine().strip()

  echo "Type is: ", type(temp)
  result = parseInt(temp)
  if result <= 0: raise newException(ValueError, "Enter a positive number")

proc getUserInput(): (int, int) =
  echo "Find the max number out of two numbers"

  var n, m: int

  while true:
    while true:
      inputMessage("Enter first integer number: ")
      try:
        n = parseInput()
        break
      except ValueError as e:
        echo e.msg

    while true:
      inputMessage("Enter second integer number: ")
      try:
        m = parseInput()
        break
      except ValueError as e:
        echo e.msg

    return (n, m)

let (num1, num2) = getUserInput()
let max_val = findMax(num1, num2)
echo "The maximum value is: ", max_val

