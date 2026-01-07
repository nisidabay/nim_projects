proc mycount (a, b: int): iterator(): int =
  # 'a' and 'b' are local to mycount and are captured by the nested iterator.
  result = iterator(): int =
    var x = a
    while x <= b:
      yield x
      inc x

let foo = mycount(1, 4)
for f in foo():
  echo f
