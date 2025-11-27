# This file demonstrates various conditional statements in Nim, including `if/elif/else` for range-based conditions and `case` expressions for discrete value matching.
# Use of conditionals
let temperature = 22
let day = "Fri"

if temperature > 30:
  echo "It's hot!"
elif temperature > 20:
  echo "It's pleasant"
else:
  echo "It's cool."


case day
of "Sat", "Sun":
  echo "Weekend!"
of "Mon", "Tue", "Wed", "Thu", "Fri":
  echo "Weekday."
else:
  echo "Invalid day."

