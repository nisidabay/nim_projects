# This file demonstrates the use of the `split` procedure from the `strutils` module with the `maxsplit` parameter.
# This allows limiting the number of splits performed on a string, useful for parsing key-value pairs.
# Use of split
import strutils

let line = "key=value=extra"
let parts = line.split('=', maxsplit = 1)
echo parts