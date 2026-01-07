# The script provides functionality to generate and display the Fibonacci
 # sequence up to a specified number of terms. It includes an iterator
 # `fiboProducer` for generating the sequence and a procedure `getFiboSeries`
 # to collect the series up to the desired count. The main loop allows user
 # interaction, accepting input to determine how many terms are generated or
 # quitting if "quit" is entered. Error handling ensures that only valid
 # integers are accepted, with appropriate feedback for invalid inputs.

import strutils

iterator fiboProducer(): int =
  var a = 0
  var b = 1
  while true:
    yield a
    let c = a + b
    a = b
    b = c

proc getFiboSeries(count: int): seq[int] =
  result = newSeq[int]()
  var i = 0
  for num in fiboProducer():
    if i >= count: break
    result.add(num)
    inc i

proc main() =
  echo "Find the fibonacci series up to a number"

  while true:
    stdout.write("Enter a number of terms to generate (or 'quit' to exit): ")
    stdout.flushFile()
    let input = stdin.readLine()

    if input.toLower() == "quit":
      break

    try:
      let num = parseInt(input)
      if num <= 0:
        echo "Please enter a positive integer."
      else:
        let series = getFiboSeries(num)
        echo series.join(", ")
    except ValueError:
      echo "Invalid input. Please enter a valid integer."

when isMainModule:
  main()

