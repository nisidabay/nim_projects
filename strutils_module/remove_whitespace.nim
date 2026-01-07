# Nim
#
# So while they all start with "strip", they each control whether to strip
# leading, trailing, or both types of whitespace.

import strutils

let messy = "  \t Hello \n "
echo messy.strip() # "Hello"
echo messy.strip(leading = true) # "Hello \n "
echo messy.strip(trailing = true) # "  \t Hello"

