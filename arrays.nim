# Use of array operations

# Procedure to print items using generics
proc printItems[T](s: seq[T]) =
  var concat: seq[string] = @[]
  echo("Printing like generics")
  for x in s:
    concat.add($x) # treat elements like strings
  echo concat

# Array of three elements
var list: array[3, int]
list[0] = 1
list[1] = 42
assert list[0] == 1, "must be 1"
assert list[1] == 42, "must be 42"
assert list[2] == 0, "must be 0"
echo("Print representation" & repr(list))

# Define custom range
var customArr: array[10 .. 20, int]
customArr[10] = 10
customArr[20] = 20
echo("Print representation" & repr(customArr))

# Making slices
let myList = @list
printItems(myList)
let myCustom = @customArr
printItems(myCustom)

# Create and initialize array
var list1: array[2, string] = ["Hola", "Adios"]
# Create array
var list2: array[2, string]
# Initialiaze array
list2[0] = "Hola"
list2[1] = "Adios"
echo("Print representation" & repr(list1))
echo("Print representation" & repr(list2))
doAssert(list1 == list2, "expected equal")
