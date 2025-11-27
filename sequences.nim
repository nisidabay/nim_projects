# This file demonstrates the declaration, manipulation, and common operations
# on sequences (dynamic arrays) in Nim, including adding, modifying, and
# deleting elements.

proc getSequenceOutput*(): string =
  var output = ""

  # Sequences in nim
  var fruits: seq[string] = @["apple", "banana"]

  # Add new fruit
  fruits.add("cherry")
  # Change fruit in [0]
  fruits[0] = "apricot"

  output.add("Fruits: " & $fruits & "\n")
  output.add("We got: " & $fruits.len & " fruits!\n")

  if "banana" in fruits:
    output.add("We have bananas!\n")

  # Delete item 2
  fruits.del(1)

  output.add("Fruits: " & $fruits & "\n")
  output.add("Now we got: " & $fruits.len & " fruits!\n")

  # Create a new sequence of type an length
  var list = newSeq[string] (3)
  list[0] = "Foo"
  list[1] = "Bar"
  list[2] = "Baz"
  list.add("Lorem") # List can grow in size
  for i in list:
    output.add(i & "\n")

  let new_list = @[4, 2, 23, 25, 123]
  for i in 0 .. new_list.len - 1:
    if i < new_list.len - 1:
      output.add($new_list[i] & " ")
    else:
      output.add($new_list[i])
  output.add("\n")

  return output

