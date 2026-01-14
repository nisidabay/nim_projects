# Nim
#
# Tuples

proc makePerson(): tuple[name: string, age: int] =
  result = (name: "Sam", age: 32)

proc personToString(): string =
  let p = makePerson()
  result = "Name: " & p.name & ", Age: " & $p.age

let p = makePerson()
echo "Name: ", p.name
echo "Age: ", p.age
echo "First field: ", p[0]
echo "Second field: ", p[1]

# If you need the string version:
let s = personToString()
echo s

