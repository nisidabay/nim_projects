# Nim
#
# raises_example.nim
# Demonstrates the {.raises: [].} pragma.

# The {.raises: [].} pragma is a promise to the compiler that a procedure
# will NOT raise any exceptions. An empty `[]` means no exceptions are
# expected. The compiler verifies this. If any code path could
# potentially raise an exception, the compiler will produce an error.
# This is also known as a "noexcept" declaration.

import std/strutils

# This procedure is guaranteed not to raise an exception.
# It performs a division, but handles the case where the divisor is zero
# to prevent a DivByZeroError.
proc safeDivision(a, b: int): int {.raises: [].} =
  if b == 0:
    return 0 # Return a default value instead of crashing.
  return a div b

# If you uncomment the line in this proc, the compiler will complain because
# `parseInt` is not marked as `raises: []` and can raise a `ValueError`.
proc riskyBusiness(s: string): int {.raises: [].} =
  # The following line would cause a compile-time error:
  # Error: unhandled effect: 'ValueError'
  # return parseInt(s)

  # This proc fulfills its promise by not having any raising code.
  return 123

when isMainModule:
  echo "Calling a proc that promises not to raise exceptions:"
  echo "safeDivision(10, 2) = ", safeDivision(10, 2)
  echo "safeDivision(10, 0) = ", safeDivision(10, 0) # Handled safely.
  echo "riskyBusiness(\"hello\") = ", riskyBusiness("hello")
