# This file demonstrates basic string validation checks using procedures from the `strutils` module in Nim.
# It specifically showcases the use of `startsWith` and `endsWith` to check if a string begins or ends with a particular substring.
import strutils

# Only these are valid in strutils:
echo "Hello".startsWith("He")
echo "World".endsWith("ld")