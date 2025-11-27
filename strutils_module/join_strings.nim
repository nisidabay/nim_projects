# This file demonstrates the use of the `join` procedure from the `strutils` module.
# It concatenates a sequence of strings into a single string, using a specified separator.
# Use of join in a sequence
import strutils

let items = @["red", "green", "blue"]
let list = items.join(", ")
echo list

