# This file demonstrates the use of multiline string literals in Nim and how to remove leading whitespace (unindent) using the `strutils.unindent` procedure.
# Multiline strings
import strutils
let multiline = """ foo
bar
baz
"""

echo multiline.unindent