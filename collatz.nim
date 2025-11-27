import strutils

#[
Collatz conjecture is a popular mathematical problem with simple rules. First
pick a number. If it is odd, multiply it by three and add one; if it is even,
divide it by two. Repeat this procedure until you arrive at one. E.g. 5 → odd →
3*5 + 1 = 16 → even → 16 / 2 = 8 → even → 4 → 2 → 1 → end! Pick an integer (as
a mutable variable) and create a loop which will print every step of the
Collatz conjecture. (Hint: use div for division)
]#

proc nextCollatz(n: Natural): Natural =
  ## Calculates the next number in a Collatz sequence.
  if n mod 2 != 0:
    result = (n * 3) + 1
  else:
    result = n div 2

proc runCollatz() =
  ## Interactively runs the Collatz sequence from a user-provided number.
  var output: seq[int]
  var n: int

  while true:
    stdout.write("Enter a positive integer: ")
    stdout.flushFile()
    let input = stdin.readLine().strip()
    try:
      n = parseInt(input)
      if n <= 0:
        echo "Please enter a positive integer."
      else:
        break
    except:
      echo "Invalid input. Please enter a valid integer."

  echo "Starting Collatz sequence for: ", n
  output.add(n) # Add the initial number to the sequence

  while n != 1:
    n = nextCollatz(n.Natural) # Cast n to Natural for nextCollatz
    output.add(n)

  echo output

when isMainModule:
  runCollatz()
