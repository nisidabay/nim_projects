# Nim - Use of zip

import sequtils

# Example-1
# Two sequences to zip together
let names = @["Alice", "Bob", "Charlie"]
let ages = @[25, 30, 35]

# Use zip to pair elements from both sequences
let pairs = zip(names, ages)

# Print the result
for (name, age) in pairs:
  echo name, " is ", age, " years old"

# Example-2
let cities = @["NYC", "LA"]
let countries = @["USA", "USA"]

let zipped = zip(cities, countries)

for (city, country) in zipped:
  echo city, " is in ", country

