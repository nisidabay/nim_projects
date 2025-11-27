# With these techniques the newline is interpreted correctly
import std/strformat

let msg = "hello"

echo &"{msg}\n"
echo fmt"{msg}{'\n'}"
echo fmt("{msg}\n")
echo "{msg}\n".fmt
