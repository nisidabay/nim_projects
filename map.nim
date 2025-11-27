import sequtils

let numbers = @[1, 2, 3, 4, 5]

let doubled = map(numbers, proc(x: int): int = x * 2)
echo doubled

