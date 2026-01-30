import std/options

proc find(haystack: string, needle: char): Option[int] =
  for i, c in haystack:
    if c == needle:
      return some(i)
  return none(int) # This line is optional, default is empty


let found = "abc".find('c')
if found.isSome:
  echo "Found 'c' at position:", $found.get()

