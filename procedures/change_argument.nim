# To change the argument must be declare as var
proc changeArgument(argument: var int) =
  echo "Initial argument value: ", argument
  argument += 5

var temp = 10
changeArgument(temp)
echo temp
changeArgument(temp)
echo temp

