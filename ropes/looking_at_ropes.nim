# Nim - Look the contents of ropes

import std/ropes

var story = rope("Once upon a time, ")
story.add("in a land far away, ")
story.add("there lived a programmer.")

echo "--- Printing pieces ---"
for piece in story.leaves:
  echo "Piece: ", piece

echo "--- Printing items ---"
# Iterate over the characters in the rope
for piece in story.items:
  echo "Piece: ", piece

