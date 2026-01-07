# Nim
#
# Use of conditionals
let temperature = 5
let day = "Sun"

# ternary-like logic
let status = if temperature > 20: "Warm" else: "Cold"

if temperature > 30:
  echo status
elif temperature > 20:
  echo status
else:
  echo status


case day
of "Sat", "Sun":
  echo "Weekend!"
of "Mon", "Tue", "Wed", "Thu", "Fri":
  echo "Weekday."
else:
  echo "Invalid day."

