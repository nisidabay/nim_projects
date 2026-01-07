# Nim
#
# Generics with iterator

iterator findAll[T](haystack: openArray[T], needle: T): int =
  for i in 0 ..< haystack.len:
    if haystack[i] == needle: yield i


for index in findAll("abcabc", 'c'):
  echo "'c' found at position: ", index, " of: ", "abcabc"

for index in findAll(@[1, 2, 3], 2):
  echo "2  found at position: ", index, " of: ", @[1, 2, 3]
