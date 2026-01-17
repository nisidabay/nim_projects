# import std/strutils, strformat
#
# proc applyToJobs(number: int, title: string) =
#   echo fmt("I'm applying to {number} {title}")
#
# proc isEven(number: int): bool =
#   number mod 2 == 0
#
# proc alphabets(word: string): (bool, bool) =
#   (word.contains("a"), word.contains("z"))
#
# proc main() =
#   applyToJobs(35, "Rust Developer")
#   echo "Is even 8? ", isEven(8)
#   echo "Is even 9? ", isEven(9)
#   echo "Has aardark an a and z? ", alphabets("aardvark")
#
# main()
proc print(data: varargs[string]) =
  var output = ""

  for value in data:
    output &= value

  echo output

print "Hello ", "I", " am ", "groot!"
