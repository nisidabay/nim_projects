#Nim 
#
# This file demonstrates the definition of custom types in Nim.

# Aliases
type
  Name = string
  Age = int

  # Person definition using aliases
  Person = tuple[name: Name, age: Age]

  # Other person definition
  otherPerson = tuple
    name: string
    age: int

var
  john: Person = (name: "John", age: 34)
  bob: otherPerson = (name: "Bob", age: 45)
  newAge: Age = 45

echo john
john.age = newAge
echo john

echo bob

