# Nim 
# From Andreas Rumpf book. Page 27
# Guided tutorial

type
  Point = object
    x: int = 0
    y: int = 0

proc resetCoordinates(points: var seq[Point]) =
  for p in low(points) .. high(points):
    points[p] = Point()

proc writeCoord(point: Point, msg: string) =
  echo msg
  echo "x: ", point.x, ", y: ", point.y

proc writeCoordinates(points: seq[Point], msg: string) =
  for p in items(points):
    writeCoord(p, msg)


var currentPoints = @[Point(x: 2, y: 3), Point(x: 5, y: 10)]

writeCoordinates(currentPoints, "Writing Coordinates")
resetCoordinates(currentPoints)
writeCoordinates(currentPoints, "Coordinates reset")
