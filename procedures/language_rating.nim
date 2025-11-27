import strutils

proc echoLanguageRating(language: string) =
  case language.toLowerAscii()
  of "nim":
    echo language, " is the best language!"
  else:
    echo language, " might be the second-best language."

proc userInput(): string =
  stdout.write("Enter your prefer language: ")
  stdout.flushFile()
  let input = stdin.readLine().strip()
  return input

let languageInput = userInput()
if languageInput == "":
  echo "Input cannot be empty"
else:
  echoLanguageRating(languageInput)
