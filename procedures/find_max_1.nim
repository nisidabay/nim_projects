# Find the maximun of two numbers
import strutils

proc findMax(x: int, y: int): int =
  if x > y:
    return x
  else:
    return y


proc getUserInput(): (int, int) =
  echo "Find the max number out of two numbers"
  while true:
    stdout.write("Enter first integer number: ")
    stdout.flushFile()
    let input1 = stdin.readLine().strip()

    stdout.write("Enter second integer number: ")
    stdout.flushFile()
    let input2 = stdin.readLine().strip()

    try:
      let n = parseInt(input1)
      let m = parseInt(input2)
      if n <= 0 or m <= 0:
        echo "Please enter a positive integer."
      else:
        return (n, m)
    except:
      echo "Invalid input. Please enter a valid integer."

let (num1, num2) = getUserInput()
let max_val = findMax(num1, num2)
echo "The maximum value is: ", max_val

