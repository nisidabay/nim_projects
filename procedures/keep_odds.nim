# Nim 
# 
# Filter a sequence for odd values

proc keepOdds(s: seq[int]): seq[int] =
  # result = @[] Sequences automatically initialize as empty
  for number in s:
    if number mod 2 == 1:
      result.add(number)

let seq = @[1, 6, 4, 43, 57, 34, 98]
echo keepOdds(seq)
