proc setAge(age: int) =
  if age < 0:
    raise newException(ValueError, "Age cannot be negative. Got: " & $age)
  echo "Age has been set to: ", age

try:
  setAge(30)
  setAge(-5)
  setAge(40)
except ValueError as e:
  echo "Error while setting age: ", e.msg

echo "Programm continues..."
