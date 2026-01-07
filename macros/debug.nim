import macros

macro debug(arg: untyped): untyped =
  quote do:
    echo "DEBUG: ", $(`arg`) & " = " & $(`arg`)

proc calculateSum(a, b: int): int =
  var sum = a + b
  echo "Inside sum"
  debug sum
  return sum

proc main() =
  let x = 10
  let y = 20
  let total = calculateSum(x, y)
  echo "Inside total"
  debug total

main()
