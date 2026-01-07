iterator countdown(n: int): int =
  var i = n
  while i >= 0:
    yield i
    dec i

for x in countdown(3):
  echo "T-minus: ", x
