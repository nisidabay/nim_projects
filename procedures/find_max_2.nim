# Nim
#
# Find biggest number

proc findBiggest(a: seq[int]): int =
  for number in a:
    if number > result:
      result = number

let numbers = @[3, 5, 11, 33, 7, 15]
echo findBiggest(numbers)
