# Nim
#
# Template example
var debugMode = false

proc expensiveCalculation(): string =
  echo "I am running a slow calculation..."
  return "Result is 42"

# TEMPLATE
# The 'msg' is not a value yet; it is a chunk of code (untyped).
template logTemplate(msg: untyped) =
  if debugMode:
    echo msg

echo "--- Starting Template Test ---"
# SUCCESS: The compiler pastes 'expensiveCalculation()' inside the 'if debugMode' block.
# Since debugMode is false, the code is skipped entirely.
logTemplate(expensiveCalculation())
