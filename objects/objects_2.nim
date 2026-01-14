# Nim
#
# Basic example of Object-Oriented Programming (OOP) using structs

type
  Dog = object
    name: string

proc bark(self: Dog) =
  echo ("Woof! My name is " & self.name & "!")

let dog = Dog(name: "Buddy")
dog.bark()

