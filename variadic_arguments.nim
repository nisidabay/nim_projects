# Nim
#
# variadic_arguments

proc getHello(names: varargs[string]): string =
  result = "Hello "
  for name in names:
    result.add(name & " ")

let names = getHello("Carlos", "Alicia", "Sergio")
echo names

