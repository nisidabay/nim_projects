# Nim
#
# Joke on language rating

import strutils

proc echoLanguageRating(language: string) =
  case language.toLowerAscii()
  of "nim":
    echo language.capitalizeAscii(), " is the best language!"
  else:
    echo language.capitalizeAscii(), " after 'Nim' might be the second-best language."

proc getInput(): string =
  stdout.write("Enter your prefer language: ")
  stdout.flushFile()

  let input = stdin.readLine().strip()
  return input

let input = getInput()
if input == "":
  echo "Input cannot be empty"
else:
  echoLanguageRating(input)
