# Capturing groups with std/nre
import std/nre

let inputString = "John Doe, age 30"
let pattern = re"(\w+) (\w+), age (\d+)"
let m_option = find(inputString, pattern)
if m_option.isSome():
  let m = m_option.get()
  echo "Full match: ", inputString[m.matchBounds]
  echo "First name: ", m.captures[0]
  echo "Last name:  ", m.captures[1]
  echo "Age:        ", m.captures[2]

