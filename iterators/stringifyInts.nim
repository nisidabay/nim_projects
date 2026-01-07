# This code demonstrates how to use a custom iterator for transforming elements
# in a collection, using a simple transformation function. This pattern can be
# very useful for applying various operations on collections in Nim or other
# languages that support similar constructs.

iterator transform[T, U](data: openArray[T], op: proc(x: T): U): U =
  for item in data:
    yield op(item)

let numbers = @[1, 2, 3]

let stringify = proc(x: int): string =
  return "String: " & $x

for s in transform(numbers, stringify):
  echo "hello: ", s
