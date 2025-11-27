# This file demonstrates various string manipulation procedures from the `strutils` module in Nim, focusing on padding and alignment.
# It showcases `alignLeft`, `align` (right-align), `center`, and `repeat`
# procedures, including the use of custom fill characters. Use of padding and
# alignment
import strutils

let word = "Nim"

echo word.alignLeft(10) # left-aligned
echo word.align(10) # right-aligned
echo word.center(10)

echo word.repeat(3)

echo word.align(8, '.')
echo word.alignLeft(8, '!')

