# Nim
#
# This file demonstrates various string replacement operations using procedures
# from the `strutils` module in Nim.

# Use of replace and multiReplace
import strutils

let original = "one swordfish, two fish"
let changed = original.replace("fish", "cat")
echo changed # "one swordcat, two cat"

let once = original.replaceWord("fish", "cat")
echo once # "one swordfish, two cat"

let text = "I like apples and bananas"
let mapping = @[("apples", "oranges"), ("bananas", "grapes")]
let result = text.multiReplace(mapping)
echo result # I like oranges and grapes

