# Nim formatting ropes

# **Note:** The `%` operator for ropes expects the arguments in the list `[]`
# to be also ropes

import std/ropes

let templateText = rope("Name: $1, Age: $2")
let formatted = $templateText % [rope("Alice"), rope("30")]

echo formatted
