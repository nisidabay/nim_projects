# Nim
#
# Example of first class procedure. Procedure calling a procedure

# Procedure to be called
proc square(x: int): int = x * x

# Calling function
proc apply(f: proc(x: int): int; x: int): int = f(x)

echo apply(square, 5)
