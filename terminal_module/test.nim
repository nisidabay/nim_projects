import std/terminal
# Save initial cursor position before any output
let startRow = 3
setCursorPos(0, startRow)
stdout.write "Processing item 1" # Uses write, not echo
setCursorPos(0, startRow) # Return to same line
eraseLine()
stdout.write "✅ Item 1 complete\n" # Overwrites the line

echo "Step 1: Downloading..." # Line 1
echo "Step 2: Processing..." # Line 2
cursorUp() # Now at Line 2
stdout.write "\r" # Start of Line 2
eraseLine()
stdout.write "Step 2: ✅ Processed" # Update Line 2

