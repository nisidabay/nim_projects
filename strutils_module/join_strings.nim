# Nim
#
# Use of join in a sequence

import strutils

let items = @["red", "green", "blue"]
let list = items.join(", ")
echo list
