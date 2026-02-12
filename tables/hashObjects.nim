# Nim

import std/[hashes, tables, algorithm] # Added algorithm for sorting

type Point = object
  x, y: int

# --- 1. THE HASH (For Tables/Sets) ---
# "Where do I store this?"
proc hash(p: Point): Hash =
  var h: Hash = 0
  h = h !& p.x.hash
  h = h !& p.y.hash
  result = !$h

# --- 2. EQUALITY (For Collision Checking) ---
# "Is this the exact item I am looking for?"
# Note: Once you define 'hash', you must define '==' to handle
# distinct objects that might technically hash to the same bucket.
proc `==`(a, b: Point): bool =
  result = (a.x == b.x) and (a.y == b.y)

# --- 3. COMPARISON (For Sorting) ---
# "Which one comes first in a list?"
# We sort by X first. If X is the same, we sort by Y.
proc `<`(a, b: Point): bool =
  if a.x != b.x:
    return a.x < b.x
  return a.y < b.y

# --- 4. STRING REPRESENTATION (For Echo) ---
# "How should I look when printed?"
proc `$`(p: Point): string =
  result = "(" & $p.x & ", " & $p.y & ")"

# ==========================================
# TEST RUN
# ==========================================

var grid = initTable[Point, string]()

# Create some points
let p1 = Point(x: 1, y: 5)
let p2 = Point(x: 5, y: 1)
let p3 = Point(x: 10, y: 10)
let p4 = Point(x: 1, y: 2) # New point to test sorting

# Insert data into the table
grid[p1] = "Player One"
grid[p2] = "Enemy Spawn"
grid[p3] = "Treasure Chest"

echo "--- Retrieving Data (Uses Hash + ==) ---"
# This works because Hash finds the bucket, and == confirms the match
echo p1, " contains: ", grid[p1]
echo p2, " contains: ", grid[p2]

echo "\n--- Existence Check ---"
# This creates a TEMPORARY point (10,10).
# It works because '==' matches it to the key stored in the table.
if grid.hasKey(Point(x: 10, y: 10)):
  echo "Found treasure at ", Point(x: 10, y: 10), "!"

echo "\n--- Sorting (Uses <) ---"
# Because we defined '<', we can now sort sequences of Points!
var path = @[p3, p2, p1, p4]
echo "Unsorted path: ", path

path.sort() # Uses our custom `<` logic
echo "Sorted path:   ", path
