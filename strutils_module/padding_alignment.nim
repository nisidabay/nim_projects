# Nim
#
# It showcases `alignLeft`, `align` (right-align), `center`, and `repeat`
# procedures, including the use of custom fill characters. Use of padding and
# alignment
import strutils

let word = "Nim"

echo "Left aligned: ", word.alignLeft(10) # left-aligned
echo "Right aligned: ", word.align(10) # right-aligned
echo "Centered: ", word.center(10)

echo "Repeat: ", word.repeat(3)

echo "Right aligned with padding: ", word.align(8, '.')
echo "Left aligned with padding: ", word.alignLeft(8, '!')

