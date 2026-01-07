# Nim
#
# Allows limiting the number of splits performed on a string, useful for
# parsing key-value pairs.

import strutils

let line = "key=value=extra"
let parts = line.split('=', maxsplit = 1)
echo parts

