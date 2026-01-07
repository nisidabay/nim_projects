# Nim
# 
# nosideeffect_example.nim
# Demonstrates the {.noSideEffect.} pragma.

# The {.noSideEffect.} pragma tells the compiler that a procedure will not
# change any state outside of its own scope. This means it won't modify
# global variables or perform I/O (like printing to the console).
# The compiler verifies this promise.
# `func` is a convenient shorthand for `proc {.noSideEffect.}`.

# This is a valid procedure with no side effects.
# It only operates on its input and local variables.
proc safeAdd(a, b: int): int {.noSideEffect.} =
  let result = a + b
  return result

var globalVar = 10

# The compiler will raise an error if you try to modify global state
# inside a proc marked with noSideEffect.
proc failsWithSideEffect(a: int): int {.noSideEffect.} =
  # Uncommenting the next line will cause a compilation error:
  # Error: 'globalVar' is a global variable; therefore, 'failsWithSideEffect' has side effects
  # globalVar = a
  return a * 2

when isMainModule:
  echo "Calling a proc with no side effects:"
  echo "safeAdd(5, 3) = ", safeAdd(5, 3)

  echo "\nThe following proc compiles because the code with side effects is commented out:"
  echo "failsWithSideEffect(5) = ", failsWithSideEffect(5)
  echo "Global variable is still unchanged: ", globalVar
