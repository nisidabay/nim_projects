# Nim
#
# TableRef allows you to modify the Table as it's a pointer
import tables
type MyTableRef = TableRef[string, int]

proc modifyTable(src: MyTableRef) =
  # Add a new entry
  src["newKey"] = 99
  # Change existing values
  src["a"] = 100

var t1: MyTableRef = newTable[string, int]()
t1["a"] = 1
t1["b"] = 2
echo "t1 before modification: ", t1
modifyTable(t1)
echo "t1 after modification: ", t1
