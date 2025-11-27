# This file demonstrates various string replacement operations using procedures from the `strutils` module in Nim.
# It showcases `replace` (replaces all occurrences), `replaceWord` (replaces whole word occurrences), and `multiReplace` (performs multiple replacements based on a sequence of old/new string pairs).
# Use of replace and multiReplace
import strutils

let original = "one fish, two fish"
let changed = original.replace("fish", "cat")
echo changed # "one cat, two cat"

let once = original.replaceWord("fish", "cat")
echo once # "one cat, two cat"

let text = "I like apples and bananas"
let mapping = @[("apples", "oranges"), ("bananas", "grapes")]
let result = text.multiReplace(mapping)
echo result