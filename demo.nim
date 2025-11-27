# This file serves as a comprehensive demonstration of various Nim language features.
# It covers:
# - Tuple creation, access, and iteration over fields.
# - Object type definition and iteration over object fields.
# - Generic procedures (`swap` and `identity`) for type-agnostic operations.
# - Enumeration (`enum`) definition and usage with `case` statements for state management.
# - Exception handling using `try`, `except`, and `finally` blocks for robust error management.
# - Object variants (discriminated unions) to define types with different fields based on a `kind` discriminator.
# - F-string formatting via the `strformat` module for easy string interpolation.

# This file has been commented by Gemini CLI.
# Function type
# proc calculate_area(width, height: int): int =
#   return width * height
#
# # Create the type
# type MathOperation = proc(a, b: int): int
#
# let op: MathOperation = calculate_area
# let result = op(2, 3)
# echo "The result is: ", result

# var scores: array[3, int] = [95, 96, 97]
# for score in scores:
#   echo score
#
# var names: seq[string] = @["Alice", "Bob"]
# for name in names:
#   echo name
#
# let vowels: set[char] = {'a', 'e', 'i', 'o', 'u'}
# echo 'a' in vowels
# echo 'b' in vowels
#
# for vowel in vowels:
#   echo vowel
#
# tuple
let person = (Name: "Charles", Age: 60, City: "Madrid")
echo person.Name
echo person[1]
proc getDetails(): void =
  for detail in person.fields:
    echo detail

getDetails()

# object
type Player = object
  name: string
  level: int
  is_online: bool

var p1: Player
p1.name = "NimMaster"
p1.level = 1
p1.is_online = true

for field_name, field_value in p1.fieldPairs:
  echo "Field Name: ", field_name, ", Value: ", field_value

# Generics
proc swap[T](a, b: T) =
  let temp = a
  a = b
  b = temp

var x = 10
var y = 20
echo "Original values x = ", x, ", y = ", y
swap(x, y)
echo "x is: ", x, " ,y is: ", y

var name1 = "Alice"
var name2 = "Bob"
echo "Original values name1 = ", name1, " ,name2 = ", name2
swap(name1, name2)
echo "name1 is: ", name1, " ,name2 is: ", name2

proc identity[T](id: T) =
  echo id

let types = (string: "Charles", int: 60, float: 5.5, bool: true)
for t in types.fields:
  identity(t)

#enums
type
  GameState = enum
    Title,
    Playing,
    Paused,
    GameOver

var command: GameState = Playing
case command:
of Playing:
  echo "We're playing"
of Title:
  echo "Displaying title"
of Paused:
  echo "Game is paused"
of GameOver:
  echo "GameOver"

# Exceptions
import math

proc safeDivide(a, b: float): float =
  try:
    if b == 0.0:
      raise newException(Exception, "Cannot divide by zero!")
    return a/b
  except Exception as e:
    echo "An error occurred: ", e.msg
    return 0.0
  finally:
    echo "Division attemp finished"

echo safeDivide(10, 5)

# object Variant
import system/iterators

type
  ShapeKind = enum
    Circle,
    Square

  Shape = object
    color: string
    case kind: ShapeKind
    of Circle:
      radius: float
    of Square:
      side: float

# Initialize myCircle using a constructor call (single step)
var myCircle: Shape = Shape(
  color: "Blue",
  kind: Circle,
  radius: 10.0 # Only provide fields for the selected kind
)

# Initialize mySquare using a constructor call (single step)
var mySquare: Shape = Shape(
  color: "Red",
  kind: Square,
  side: 20.0 # Only provide fields for the selected kind
)

# Your iteration loops will now work correctly!
for field_name, field_value in myCircle.fieldPairs:
  echo "Circle Field: ", field_name, " = ", field_value

for field_name, field_value in mySquare.fieldPairs:
  echo "Square Field: ", field_name, " = ", field_value


import strformat # Needed for f-string functionality

let
  item_count = 3
  price = 15.50

# F-string embeds variables cleanly
let receipt = &"Your order has {item_count} items totaling ${price:.2f}."
echo receipt
# Output: Your order has 3 items totaling 5.50.