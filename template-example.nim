# This file demonstrates the use of templates in Nim, specifically a `debugLog` template that conditionally outputs debug messages based on a compile-time constant.
# Template example
const debugMode = true
template debugLog(msg: untyped) =
  when debugMode:
    echo "DEBUG: ", msg

let name = "Alice"
debugLog "User is: " & name
debuglog 42 + 100