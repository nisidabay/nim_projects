# Nim
#
# Change argument value. The argument MUST BE VAR

proc changeArgument(argument: var int) =
  echo "Initial argument value: ", argument
  argument += 5

# Also this
var temp = 10
changeArgument(temp)
echo temp
changeArgument(temp)
echo temp

