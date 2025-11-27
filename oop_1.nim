# This file provides a basic example of Object-Oriented Programming (OOP) in Nim.
# It defines a `Dog` object type with a `name` field and an associated `bark` procedure.
# Example
type
  Dog = object
    name: string

proc bark(self: Dog) =
  echo ("Woof! My name is " & self.name & "!")

let dog = Dog(name: "Buddy")
dog.bark()