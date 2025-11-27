# Use of 'contains' for any 'match' anywhere in the string
import std/re

let text = "My phone is 555-1234"
if text.contains(re"\d{3}-\d{4}"):
  echo "Found a phone number!"
