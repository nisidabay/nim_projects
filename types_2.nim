#Nim 
#
# This file demonstrates the definition of custom types in Nim.

type
  # Aliases
  Name = string
  Age = int

  Person = tuple[name: Name, age: Age]

  # Another way to define a tuple type with named fields
  AnotherSyntax = tuple
    fieldOne: string
    secondField: int

var
  john: Person = (name: "John", age: 34)
  newAge: Age = 45
  example: AnotherSyntax = (fieldOne: "hello", secondField: 123)

# Print the initial 'john' tuple
echo john
# Update the 'age' field of the 'john' tuple
john.age = newAge
echo john

# Print the 'example' tuple
echo example

