import std/math # Required for PI

type
  ShapeKind = enum
    Circle,
    Square

  Shape = object
    color: string
    case kind: ShapeKind
    of Circle:
      radius: float
    of Square:
      side: float

# Define the function
func calculateArea(s: Shape): float =
  case s.kind
  of Circle:
    result = PI * s.radius * s.radius
  of Square:
    result = s.side * s.side

# Initialize instances
let myCircle = Shape(kind: Circle, color: "Blue", radius: 10.0)
let mySquare = Shape(kind: Square, color: "Red", side: 20.0)

# Execute
when isMainModule:
  echo "Circle Area: ", myCircle.calculateArea()
  echo "Square Area: ", mySquare.calculateArea()
