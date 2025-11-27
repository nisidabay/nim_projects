# Use 'match' to test if the beginning of the string matches the pattern
import std/re

let text = "123-45-6789 This is my SSN"
if text.match(re"\d{3}-\d{2}-\d{4}"):
  echo "Valid SSN format at start"

# Use anchors to match the whole string
if text.match(re"^\d{3}-\d{2}-\d{4}.*$"):
  echo "Entire string is a valid SSN"

