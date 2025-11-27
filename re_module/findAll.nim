# Use 'find' to get all non-overlapping matches as sequence
import std/re

let text = "Dates: 2023-05-10, 2024-12-25"
let dates = text.findAll(re"\d{4}-\d{2}-\d{2}")
for d in dates:
  echo "Found date: ", d
