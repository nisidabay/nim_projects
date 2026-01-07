import macros

macro helloWorld(): untyped =
  result = quote do:
    echo("Hello, World!")

helloWorld()
