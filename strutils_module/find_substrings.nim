# This file demonstrates various string searching operations using procedures from the `strutils` module in Nim.
# It showcases `find` (to get the index of the first occurrence), `rfind` (for
# the last occurrence), and `contains` (to check for presence) of substrings.
# use of find, rfind and contains
import strutils

let s = "The quick brown fox"

echo s.find("quick") #Returns the index 4
echo s.find("lazy") #Returns -1 (not found)
echo s.rfind("o") #Returns index of last occurrence 17
if s.contains("brown"):
  echo "Found brown!"

