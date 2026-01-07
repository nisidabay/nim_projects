# Nim
#
# Remove duplicate consecutive characters

proc deduplicateAdjacent(s: string): string =
  if s.len == 0: return ""
  result = newStringOfCap(s.len)
  result.add(s[0])
  for i in 1 ..< s.len:
    if s[i] != s[i - 1]:
      result.add(s[i])

# ✅ Usage
echo "aaabbbcccaaa".deduplicateAdjacent() # "abca"
echo "mississippi".deduplicateAdjacent() # "misisipi"
