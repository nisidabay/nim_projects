# String literal not interpreted
import std/strformat

let msg = "hello"
echo fmt"{msg}\n" # hello\n
assert fmt"{msg}\n" == "hello\\n"
