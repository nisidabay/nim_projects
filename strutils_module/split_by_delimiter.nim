# This file demonstrates the use of the `split` procedure from the `strutils` module.
# It splits a string into a sequence of substrings using a specified delimiter.
# Use of split
import strutils

let text = "apple, banana, cherry"
let fruits = text.split(',')
echo fruits

