# Nim - Use of foldl

# The foldl method of sequtils is a template that folds a sequence from left to
# right, applying a given operation cumulatively to the elements of the sequence.
# It takes three parameters: the sequence to be folded, an operation (an
# expression using variables a and b), and optionally a starting value (first
# parameter).

import sequtils

# Example-1
echo(@[14, 35, -7, 47, 98].foldl(min(a, b)))
echo(@[14, 35, -7, 47, 98].foldl(max(a, b)))

# Example-2
let words = @["Nim ", "is ", "cool"]
let message = foldl(words, a & b)

echo message

# Example-3
let numbers = @[5, 9, 11]
let total = foldl(numbers, a + b)

echo total
