# Nim
#
# It splits a string into a sequence of substrings using a specified delimiter.

import strutils

let text = "apple, banana, cherry"
let fruits = text.split(',')
echo fruits

