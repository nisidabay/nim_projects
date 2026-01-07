# Nim
#
# Group by pattern using tables

import std/tables, std/strformat

type Employee = object
  id: int
  name: string
  dept: string

let employees = @[
  Employee(id: 1, name: "John", dept: "Sales"),
  Employee(id: 2, name: "Jane", dept: "IT"),
  Employee(id: 3, name: "Bob", dept: "HR"),
  Employee(id: 4, name: "Alice", dept: "Sales")
]

# Department, List of employees
var deptDirectory = initTable[string, seq[Employee]]()

# Add employees to Department
for e in employees:
  deptDirectory.mgetOrPut(e.dept, @[]).add(e)

for dept, staff in deptDirectory:
  echo &"=== {dept} ==="
  for s in staff:
    echo &"{s.id} {s.name}"
