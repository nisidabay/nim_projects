import macros

macro helloWorld(): untyped =
  result = quote do:
    echo("Hello, World!")

macro sayHello(n: untyped): untyped =
  result = quote do:
    echo "Hello, ", `n`, "!"


let world = "Earth"
sayHello(world)
helloWorld()
