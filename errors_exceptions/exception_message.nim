# define the function
func divide(a, b: int): int =
  if b == 0:
    # Stop everything and signal an error
    raise newException(ValueError, "Division by zero")
  else:
    # Return the raw, unwrapped integer
    return a div b

# Run the code
try:
  let result = divide(10, 0)
  echo "Result: ", result
except ValueError:
  # This block only runs if the error was raised
  echo "Error: ", getCurrentExceptionMsg()
