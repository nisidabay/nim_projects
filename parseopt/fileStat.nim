import std/parseopt, strutils, os

var
  filename = ""
  verbose = false
  retries = 3

proc getHelp() =
  echo "Usage: fileStat [options] filename"
  echo "Options:"
  echo "  -h, --help           Show this help message"
  echo "  -v, --verbose        Enable verbose output"
  echo "  -r, --retries=N      Set number of retries (default: 3)"


proc parseArgs() =
  for kind, key, val in getopt():
    case kind
    of cmdArgument:
      filename = key

    of cmdLongOption, cmdShortOption:
      case key
      of "help", "h":
        getHelp()
        quit(0)

      of "verbose", "v":
        verbose = true

      of "retries", "r":
        try:
          retries = parseInt(val)
        except ValueError:
          echo "Error: --retries must be an integer."
          quit(1)
      else:
        echo "Unknown option: ", key
    of cmdEnd: discard

when isMainModule:

  if paramCount() == 0:
    getHelp()
    quit(1)

  parseArgs()

  if not fileExists(filename):
    echo "Error: File not found -> ", filename
    quit(1)

  if verbose:
    echo "Processing file: '", filename, "'"
    echo "Verbose mode: on"
    echo "Retries set to: ", retries

  try:
    let content = readFile(filename)
    let lineCount = content.splitLines().len
    let wordCount = content.splitWhitespace().len
    let charCount = content.len

    echo "--- File Statistics ---"
    echo "Lines:      ", lineCount
    echo "Words:      ", wordCount
    echo "Characters: ", charCount
    echo "-----------------------"

  except IOError as e:
    echo "Error reading file: ", e.msg
    quit(1)
