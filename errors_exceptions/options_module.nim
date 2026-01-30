
import std/options

# func = pure function (no side effects)
# Option[int] = Standard type for "Maybe an int, maybe nothing"
func divide(a, b: int): Option[int] =
  if b == 0:
    return none(int) # Standard failure: Return "Nothing"
  else:
    return some(a div b) # Standard success: Wrap result in "some"

# --- Usage ---

let result = divide(10, 0)

# .isSome checks if the box has a value (Standard method)
if result.isSome:
  # .get opens the box (Unsafe if empty, so always check isSome first)
  echo "Result: ", result.get()
else:
  echo "Error: Division by zero"
