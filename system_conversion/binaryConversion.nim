import strutils, algorithm, strformat

# 1. Decimal to Binary
# Converts decimal integer to a binary string manually
proc decimalToBinary(decimal: int): string =
  if decimal == 0:
    return "0"

  var tempDecimal = decimal
  var binarySeq: seq[char] = @[]

  while tempDecimal > 0:
    # '0' + (decimal & 1) logic
    binarySeq.add(char(ord('0') + (tempDecimal and 1)))
    tempDecimal = tempDecimal shr 1 # bitwise shift right
  
  # Nim strings are not reversed in place easily, so we reverse the sequence
  # and join it back into a string.
  reverse(binarySeq)
  return binarySeq.join()

# 2. Binary to Decimal
# Converts binary string to decimal integer manually
proc binaryToDecimal(binary: string): int =
  var decimal = 0
  for ch in binary:
    # decimal * 2 + (char - '0')
    decimal = decimal * 2 + (ord(ch) - ord('0'))
  return decimal

# 3. Decimal to Octal
# The C code used sprintf("%o"). Nim has toOct() in strutils.
proc decimalToOctal(decimal: int): string =
  return fmt"{decimal:o}"

# 4. Octal to Decimal
# Converts octal string to decimal integer manually
proc octalToDecimal(octal: string): int =
  var decimal = 0
  for ch in octal:
    decimal = decimal * 8 + (ord(ch) - ord('0'))
  return decimal

# 5. Hexadecimal to Binary
# Converts hex string -> int -> binary string
proc hexadecimalToBinary(hexStr: string): string =
  var hexNum: int
  try:
    # Equivalent to sscanf("%x")
    hexNum = hexStr.parseHexInt()
  except ValueError:
    return "Invalid Hex"

  # Reuse our existing logic to convert that int to binary
  return decimalToBinary(hexNum)

# 6. Binary to Hexadecimal
# Pads binary string and converts 4-bit groups to Hex digits
proc binaryToHexadecimal(binary: string): string =
  var binStr = binary
  let length = binStr.len

  # Calculate padding needed to make length a multiple of 4
  let padding = (4 - (length mod 4)) mod 4

  # Pad with leading zeros
  if padding > 0:
    binStr = repeat('0', padding) & binStr

  var hexadecimal = ""

  # Iterate through groups of 4
  var i = 0
  while i < binStr.len:
    let group = binStr[i .. i+3]

    # Convert the 4-bit binary string to an integer
    try:
      let val = group.parseBinInt()
      # Convert the integer (0-15) to a single hex digit and append
      hexadecimal.add(val.toHex(1))
    except ValueError:
      return "Invalid Binary Input"

    i += 4

  return hexadecimal

# Driver Code
proc main() =
  var choice = 0

  while true:
    echo "\nMenu:"
    echo "1. Decimal to Binary"
    echo "2. Binary to Decimal"
    echo "3. Decimal to Octal"
    echo "4. Octal to Decimal"
    echo "5. Hexadecimal to Binary"
    echo "6. Binary to Hexadecimal"
    echo "7. Exit"
    stdout.write("Enter your choice: ")

    try:
      let line = stdin.readLine()
      if line == "": continue
      choice = line.parseInt()
    except ValueError:
      echo "Please enter a valid number."
      continue

    if choice == 7:
      echo "Goodbye!"
      break

    case choice:
    of 1:
      stdout.write("Enter a decimal number: ")
      let input = stdin.readLine().parseInt()
      echo "Decimal to Binary: ", decimalToBinary(input)
    of 2:
      stdout.write("Enter a binary number: ")
      let input = stdin.readLine()
      echo "Binary to Decimal: ", binaryToDecimal(input)
    of 3:
      stdout.write("Enter a decimal number: ")
      let input = stdin.readLine().parseInt()
      echo "Decimal to Octal: ", decimalToOctal(input)
    of 4:
      stdout.write("Enter an octal number: ")
      let input = stdin.readLine()
      echo "Octal to Decimal: ", octalToDecimal(input)
    of 5:
      stdout.write("Enter a hexadecimal number: ")
      let input = stdin.readLine()
      echo "Hexadecimal to Binary: ", hexadecimalToBinary(input)
    of 6:
      stdout.write("Enter a binary number: ")
      let input = stdin.readLine()
      echo "Binary to Hexadecimal: ", binaryToHexadecimal(input)
    else:
      echo "Invalid choice. Please enter a valid option."

# Run the main procedure
if isMainModule:
  main()
