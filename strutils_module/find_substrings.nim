# Nim 
#
# This file demonstrates various string searching operations using procedures
# from the `strutils` module in Nim.

import strutils

let s = "The quick brown fox"

echo s.find("quick") #Returns the index 4
echo s.find("lazy") #Returns -1 (not found)
echo s.rfind("o") #Returns index of last occurrence 17
if s.contains("brown"):
  echo "Found brown!"
