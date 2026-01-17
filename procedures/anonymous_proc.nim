# Nim
#
# Anonymous procedure
let complexResult = (proc (): int =
  var tempSum = 0
  for i in 1..5:
    tempSum += i
  tempSum * 2
)()

echo complexResult


