# Swap words using 'replace'
import std/nre

let text = "Swap: foo-bar"
let result = replace(text, re"(\w+)-(\w+)", "$2-$1")
echo result
