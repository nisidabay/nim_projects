import std/[os, strutils, posix, sysrand, terminal, parseopt]

type
  Complexity = enum
    cmpWeak, cmpMedium, cmpStrong, cmpVeryStrong

# Return a string based on Complexity
proc getCharset(level: Complexity): string =
  case level
  of cmpWeak: return "abcdefghijklmnopqrstuvwxyz0123456789"
  of cmpMedium: return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  of cmpStrong: return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*"
  of cmpVeryStrong: return "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_=+[]{};':\",./<>?`~|\\"

# Generate random password based on Complexity range with urandom
proc generatePassword(len: int, level: Complexity): string =
  let pool = getCharset(level)
  result = newStringOfCap(len)

  let randomBytes = urandom(len)
  for b in randomBytes:
    let index = b.int mod pool.len
    result.add(pool[index])

# Save the password
proc saveSecret(name, content: string) =
  let dir = getHomeDir() / "Documents" / "Passwords"

  if not dirExists(dir):
    createDir(dir)
    discard chmod(dir.cstring, Mode(0o700))

  let filePath = dir / (name & ".txt")

  try:
    writeFile(filePath, content & "\n")
    discard chmod(filePath.cstring, Mode(0o600))
  except IOError as e:
    styledEcho fgRed, "Error: Could not write to file. ", e.msg
    quit(1)

# Help menu
proc showHelp() =
  styledEcho styleBright, fgCyan, "NimPass Generator"
  echo "A secure, local-first password tool."
  echo "\nUsage:"
  styledEcho fgYellow, "  password [options] <name>"
  echo "\nArguments:"
  echo "  <name>              The service name (e.g., github)"
  echo "\nOptions:"
  echo "  -h, --help          Show this menu"
  echo "  -l, --length:N      Set length (Default: 20)"
  echo "  -c, --complexity:C  Set complexity: weak, medium, strong, very_strong"
  echo "\nExample:"
  styledEcho fgGreen, "  password -l:32 -c:very_strong personal_email"
  quit(0)

# Main entry point
proc main() =
  var
    length = 20
    level = cmpStrong
    entryName = ""
    p = initOptParser()

  # Argument Parsing
  for kind, key, val in p.getopt():
    case kind
    of cmdLongOption, cmdShortOption:
      case key.toLowerAscii()
      of "h", "help": showHelp()
      of "l", "length":
        try:
          length = parseInt(val)
        except ValueError:
          styledEcho fgRed, "Error: Length must be an integer."
          quit(1)
      of "c", "complexity":
        case val.toLowerAscii()
        of "weak": level = cmpWeak
        of "medium": level = cmpMedium
        of "strong": level = cmpStrong
        of "very_strong": level = cmpVeryStrong
        else:
          styledEcho fgRed, "Error: Invalid complexity level."
          quit(1)
    of cmdArgument:
      entryName = key
    of cmdEnd: discard

  if entryName == "":
    styledEcho fgRed, "Error: Missing password name."
    showHelp()

  let secret = generatePassword(length, level)
  saveSecret(entryName, secret)

  styledEcho fgGreen, "✔ Generated ", fgCyan, $level, fgGreen,
      " password for '", entryName, "'"

when isMainModule:
  main()
