# Nim 
# From Andreas Rumpf book. Page 22
# Guided tutorial

import pixels

type
  Point = object
    x: int
    y: int

type
  Direction = enum
    Horizontal
    Vertical


proc drawHorizontalLine(start: Point, length: Positive) =
  for delta in 0 .. length:
    putPixel(start.x + delta, start.y)


proc drawVerticalLine(start: Point, length: Positive) =
  for delta in 0 .. length:
    putPixel(start.x, start.y + delta)

proc drawLine(start: Point, length: Positive, direction: Direction) =
  case direction
  of Horizontal:
    drawHorizontalLine(start, length)
  of Vertical:
    drawVerticalLine(start, length)

let a = Point(x: 60, y: 40)

drawLine(a, 50, Horizontal)
drawLine(a, 30, Vertical)
