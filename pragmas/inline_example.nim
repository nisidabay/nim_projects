# Nim
# 
# inline_example.nim
# Demonstrates the {.inline.} pragma.

# The {.inline.} pragma is a hint to the compiler to replace a call
# to a procedure with the procedure's body, avoiding the overhead of a
# regular function call. This is most effective for small, frequently-called
# procedures in performance-critical code.

proc addOne(x: int): int {.inline.} =
  # This simple logic will be "copy-pasted" at the call site.
  return x + 1

proc calculateSum(n: int): int =
  var total = 0
  for i in 1..n:
    # Because addOne is inlined, the loop essentially becomes:
    # total += i + 1
    # This avoids millions of function calls in a tight loop.
    total += addOne(i)
  return total

when isMainModule:
  let result = calculateSum(10)
  echo "The result of calculateSum(10) is: ", result
  echo "This demonstrates that the inlined logic was executed correctly."
