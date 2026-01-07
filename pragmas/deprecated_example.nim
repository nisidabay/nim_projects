# Nim
#
# deprecated_example.nim
# Demonstrates the {.deprecated.} pragma.

# The {.deprecated.} pragma marks a procedure or type as outdated.
# When code tries to use it, the compiler will issue a warning,
# encouraging developers to switch to a newer alternative.

proc oldAndBusted() {.deprecated: "Use newAndShiny() instead".} =
  echo "This is the old way of doing things."

proc newAndShiny() =
  echo "This is the new, improved way!"

when isMainModule:
  # Using this will generate a compiler warning like:
  # ... Warning: oldAndBusted is deprecated; Use newAndShiny() instead [Deprecated]
  oldAndBusted()

  echo "\nYou should be using this one:"
  newAndShiny()
