# Nim
#
# Examples of working with Arrays and Slices


# A flexible tool to print a list of any type (numbers, strings, etc.)
proc displayItems[T](items: openArray[T]) =
  echo "--- Displaying List ---"
  for item in items:
    stdout.write($item & " ")
  echo ""

# --- 1. Working with Numbers ---

# Create a fixed list that holds exactly 3 numbers
var numbers: array[3, int]

# Fill the list with data
numbers[0] = 1
numbers[1] = 42

# specific checks to ensure the data is correct
assert numbers[0] == 1, "First item must be 1"
assert numbers[1] == 42, "Second item must be 42"
assert numbers[2] == 0, "Third item should be 0 by default"

# 'repr' shows the raw, internal look of the data
echo "Raw internal view: " & repr(numbers)

# --- 2. Custom Number Ranges ---

# Arrays don't have to start at 0. This one uses indexes 10 through 20.
var rangeList: array[10 .. 20, int]

rangeList[10] = 10
rangeList[20] = 20

echo "Raw view of custom range: " & repr(rangeList)

# --- 3. Converting to Sequences ---

# The '@' symbol turns a fixed array into a flexible sequence
let numberSequence = @numbers
displayItems(numberSequence)

let rangeSequence = @rangeList
displayItems(rangeSequence)

# --- 4. Working with Text (Strings) ---

# Method A: Create and fill the list in one step
var greetingsA: array[2, string] = ["Hola", "Adios"]

# Method B: Create the list first, then fill it later
var greetingsB: array[2, string]
greetingsB[0] = "Hola"
greetingsB[1] = "Adios"

echo "Group A: " & repr(greetingsA)
echo "Group B: " & repr(greetingsB)

# Verify that both methods produced the exact same result
doAssert(greetingsA == greetingsB, "Both lists should be identical")
