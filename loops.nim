# This file demonstrates various looping constructs in Nim, including inclusive
# and exclusive `for` loops for iterating over ranges and collections, and
# `while` loops for conditional iteration. foor loops

# Inclusive loops
for i in 0..3:
  echo "Count: ", i

for fruit in ["apple", "banana", "cherry"]:
  echo "I like ", fruit

# Excluive loops, until number 9
for i in 0..<10:
  echo "Count: ", i

# while loops
var counter = 10
while counter > 0:
  echo "T-minus ", counter
  counter -= 1
echo "Liftoff!"

# This is a Nim function. The starter must be greater than finish
for n in countdown(4, 0):
  echo n
echo "Liftoff!"

for n in countdown(-3, -9, 2):
  echo n

# Strings are iterable
let word = "alphabet"
for letter in word:
  echo letter

for i, letter in word:
  echo "letter ", i, " is: ", letter
