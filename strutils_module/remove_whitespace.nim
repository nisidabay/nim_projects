# Remove whitespaces
import strutils

let messy = "  \t Hello \n "
echo messy.strip() # "Hello"
echo messy.strip(leading = true) # "Hello \n "
echo messy.strip(trailing = true) # "  \t Hello"

