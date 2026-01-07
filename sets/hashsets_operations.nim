import std/sets

var s1 = initHashSet[string]()
var s2 = initHashSet[string]()

s1 = toHashSet(["bob", "peter"])
s1.incl("alice")
echo "HashSet s1 has: ", s1

s2 = toHashSet(["peter", "mark"])
echo "HashSet s2 has: ", s2

let union = s1 + s2
echo "union HashSet s1 + HashSet s2 = ", union

let intersection = s1 * s2
echo "intersection HashSet s1 * HashSet s2 = ", intersection

let difference = s1 - s2
echo "difference HashSet s1 - HashSet s2: only what's inside s1 = ", difference

echo "is s1 a subset of s2?: ", s1 <= s2
echo "is s2 a subset of s3?: ", s2 <= s1
let ok = sets.contains(s1, "alice")
echo "s1 contains alice?: ", ok

let mm = sets.disjoint(s1, s2)
echo "s1 and s2 have nothing in common? : ", mm

