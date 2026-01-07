# Nim
#
# Template example. Generics in templates are "untyped"
template swap(a, b: untyped) =
    let temp = a
    a = b
    b = temp

var x = 10
var y = 20
swap(x, y)
echo "x: ", x, ", y: ", y

var s1 = "Hello"
var s2 = "World"
swap(s1, s2)
echo "s1: ", s1, ", s2: ", s2

