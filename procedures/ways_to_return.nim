# Nim
#
# Implicit and explicit returns

proc hello(name: string): string =
  # This is a test comment
  "Hello " & name & "!"


proc greet(name: string): string =
  result = "Greetings, " & name & "!"

proc add(a, b: int): int =
  # return is optional, last expression is returned return a+b
  a+b

let hi = hello("Nim user")
let message = greet("Nim")
let sum = add(5, 7)
echo hi
echo message
echo "5 + 7 =", sum

