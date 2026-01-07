# Use of case statement
#
import strutils

let numbers: seq[int] = @[1, 3, 5, 7, 12, 2, 34]

proc checknumbers[T](numbers: openArray[T]) =
  for num in numbers:
    case num
    of 1, 3, 5, 7:
      echo "Odd numbers: ", num
    of 2, 12, 34:
      echo "Even numbers: ", num
    else:
      echo "Unknown number: ", num

checknumbers(numbers)

proc userConfirmation(): bool =
  stdout.write("Do you want to proceed? (y/N): ")
  stdout.flushFile()
  let response = readLine(stdin).strip().toLowerAscii()
  case response
  of "Y".toLowerAscii():
    return true
  of "N".toLowerAscii():
    return false
  else:
    return false

let confirmed = userConfirmation()
if confirmed:
  echo "Proceeding..."
else:
  echo "Cancelling..."
