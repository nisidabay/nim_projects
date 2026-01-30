# This module implements types which encapsulate an optional value.
#
# A value of type Option[T] either contains a value x (represented as some(x))
# or is empty (none(T)).
#
# This can be useful when you have a value that can be present or not. The
# absence of a value is often represented by nil, but that is not always
# available, nor is it always a good solution.

import std/[options, strutils]

# A helper that tries to parse a string to int safely
func safeParseInt(s: string): Option[int] =
  try:
    return some(parseInt(s))
  except ValueError:
    return none(int)

# A helper to validate port range
func validatePort(p: int): Option[int] =
  if p > 0 and p < 65535:
    return some(p)
  else:
    return none(int)

# --- MAIN LOGIC ---

let rawConfig = "port:8080" # Try "port:bad", "port:99999", or "port:8080"

# Step 1: Extract the number part as a string
let numberString: Option[string] =
  if rawConfig.startsWith("port:"):
    some(rawConfig.substr(5))
  else:
    none(string)

# Step 2 & 3: Parse and Validate
# We use flatMap because safeParseInt returns an Option.
# We use flatMap again because validatePort returns an Option.
let validPort = numberString
  .flatMap(safeParseInt)
  .flatMap(validatePort)

if validPort.isSome:
  echo "Server starting on port: ", validPort.get()
else:
  echo "Invalid configuration."
