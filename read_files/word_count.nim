# Warning: Avoid using readAll() for large streams or infinite streams; it
# loads everything into memory.

# Check if data is actually being piped (optional but good practice)

import std/strutils


try:
  # Reads until EOF (End of Stream)
  let content = stdin.readAll()

  if content.len == 0:
    echo "⚠️  No input received from pipe."
  else:
    let words = content.splitWhitespace()
    echo "📊 Statistics:"
    echo "   Characters: ", content.len
    echo "   Words:      ", words.len

except IOError as e:
  stderr.write("❌ Error reading stdin: " & e.msg & "\n")
