# Nim
#
# Iterators

# This Nim code defines an iterator `findAll` that searches through a given
# string (`haystack`) for all occurrences of a specified character (`needle`).
# It yields the starting index of each occurrence. The main part of the script
# iterates over these indices and prints out the positions where 'c' is found
# in the string "abcabc".: ", index

iterator findAll(haystack: string, needle: char): int =
  for i in 0 ..< haystack.len:
    if haystack[i] == needle: yield i


for index in findAll("abcabc", 'c'):
  echo "'c' found at position: ", index, " of: ", "abcabc"

