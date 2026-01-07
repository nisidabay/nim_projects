# Nim
#
# Use of escape and unescape

import strutils

let raw = "She said \"Hello!\""
let escaped = raw.escape()
echo "Raw string: ", raw
echo "Escaped string: ", escaped

let dangerous = "rm -rf dummy_file"
let safe = dangerous.escape()
echo "Raw string: ", dangerous
echo "Escaped string: ", safe

echo "⚠️ To unescape the string must be first scape!!!"
let unescaped = safe.unescape()
echo "Unescaped string: ", unescaped
