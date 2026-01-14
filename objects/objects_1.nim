# Nim
#
# Objects in nim (structs)

type
  Point = object
    x, y: float

  Person = object
    name: string
    age: int

proc location(self: Point) =
  echo "I'm a point at location: " & $self.x & " and " & $self.y

proc greeting(self: Person) =
  echo "Hi, I'm " & self.name & ". I'm " & $self.age

let newPerson = Person(name: "Carlos", age: 30)
newPerson.greeting()

let newPoint = Point(x: 10.0, y: 20.0)
newPoint.location()

