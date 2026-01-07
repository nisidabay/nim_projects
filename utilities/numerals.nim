# Nim 
#
# Convert integers to Roman numeral

# Define mappings as a constant array of tuples (order matters!)
const ValToRoman = [
  (1000, "M"), (900, "CM"), (500, "D"), (400, "CD"),
  (100, "C"), (90, "XC"), (50, "L"), (40, "XL"),
  (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")
]

func toRoman(n: int): string =
  ## Converts integer to Roman numeral.
  ## Raises ValueError if input is out of standard range (1..3999).
  if n <= 0 or n >= 4000:
    raise newException(ValueError, "Number must be between 1 and 3999")

  # 'result' is implicitly defined as "" (empty string)
  var remaining = n
  for (val, roman) in ValToRoman:
    while remaining >= val:
      result.add(roman)
      remaining -= val

# --- Test ---
when isMainModule:
  try:
    echo "1964 -> ", toRoman(1964) # MCMLXIV
    echo "1990 -> ", toRoman(1990) # MCMXC
    echo "2025 -> ", toRoman(2025) # MMXXV
    discard toRoman(5000) # Should trigger error
  except ValueError as e:
    echo "Error caught: ", e.msg
