import strutils

let raw = "She said \"Hello!\""
let escaped = raw.escape()
echo "Raw string: ", raw
echo "Escaped string: ", escaped

let dangerous = "rm -rf file"
let safe = dangerous.escape()
echo "Escaped string: ", safe

# To unescape the string must be first scape!!!
let unescaped = safe.unescape()
echo "Unescaped string: ", unescaped
