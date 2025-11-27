# This file demonstrates the definition and usage of custom object types in Nim, including their fields and associated procedures.
# Objects in nim
type
  Point = object
    x, y: float

  Person = object
    name: string
    age: int

proc location(self: Point) =
  let x: Point.x = 25
  let y: Point.y = 50
  echo "I'm a point at location: " & $x & " and " & $y

proc greeting(self: Person) =
  let name: Person.name = "Carlos"
  let age: Person.age = 60
  echo "Hi, I'm " & name & ". I'm " & $age

let newPerson = Person()
newPerson.greeting()

let newPoint = Point()
newPoint.location()