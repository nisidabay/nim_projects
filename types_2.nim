# This file demonstrates the definition of custom types in Nim.
# It covers creating type aliases for basic types (`Name`, `Age`) and defining tuple types (`Person`, `AnotherSyntax`) with named fields.
# The example also shows how to declare, initialize, and modify variables of these custom types.
# Define custom types
type
  # Alias for string type
  Name = string
  # Alias for int type
  Age = int
  # Define a tuple type 'Person' with named fields 'name' (of type Name) and
  # 'age' (of type Age)
  Person = tuple[name: Name, age: Age]
  # Another way to define a tuple type with named fields
  AnotherSyntax = tuple
    fieldOne: string
    secondField: int

# Declare variables
var
  # Initialize a 'Person' variable 'john'
  john: Person = (name: "John", age: 34)
  # Initialize an 'Age' variable 'newAge'
  newAge: Age = 45
  # Initialize an 'AnotherSyntax' variable 'example'
  example: AnotherSyntax = (fieldOne: "hello", secondField: 123)

# Print the initial 'john' tuple
echo john
# Update the 'age' field of the 'john' tuple
john.age = newAge
# Print the updated 'john' tuple
echo john

# Print the 'example' tuple
echo example