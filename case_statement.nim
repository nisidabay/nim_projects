# Use of case statement
#
import strutils

let numbers: seq[int] = @[1, 3, 5, 7, 12, 2, 34]

proc checknumbers(numbers: seq[int]) =
  for x in numbers:
    case x
    of 1, 3, 5, 7:
      echo "Odd numbers: ", x
    of 2, 12, 34:
      echo "Even numbers: ", x
    else:
      echo "Unknown number: ", x

checknumbers(numbers)

proc userConfirmation(): bool =
  stdout.write("Do you want to proceed? (y/N): ")
  stdout.flushFile()
  let response = readLine(stdin).strip().toLowerAscii()
  case response
  of "Y", "y":
    return true
  of "N", "n":
    return false
  else:
    return false

let confirmed = userConfirmation()
if confirmed:
  echo "Proceeding..."
else:
  echo "Cancelling..."
