import os, strutils

# The 'log_filter' procedure reads from standard input (stdin) line by line.
proc filterLogFile(searchString: string) =
  for line in stdin.lines:
    if line.contains(searchString):
      echo line

when isMainModule:
  # Check if a search term was provided as a command-line argument.
  if paramCount() < 1:
    echo "Usage: ./log_filter <search_term> < log_file.txt"
    echo "Usage: cat filename | ./log_filer  <search_term>"
    quit(1)

  # Get the first command-line argument (index 1 is the first argument after
  # the program name).
  let searchTerm = paramStr(1)

  # Execute the filtering logic.
  filterLogFile(searchTerm)
