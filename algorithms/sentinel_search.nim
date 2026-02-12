#The Sentinel Search technique is an optimization of the Linear Search
#algorithm. It involves adding a "sentinel" element to the end of the array
#before performing the search. This eliminates the need for a post-loop check
#to see if the last element was the target, as the sentinel ensures that the
#loop will always terminate with the target found or confirmed not present.

proc displayElements[T](slice: openArray[T], msg: string) =
  var result = ""
  for element in slice:
    if result.len > 0:
      result.add(", ")
    result.add($element)
  echo msg, ":", result

proc findNumber[T](arr: var seq[T], target: T): int =
  displayElements(arr, "original")
  let n = arr.len
  if n == 0:
    return -1

  let originalLast = arr[n - 1]

  arr[n - 1] = target # Set sentinel
  displayElements(arr, "Modified")

  var i = 0
  # The loop will definitely terminate because arr[n-1] is target
  while arr[i] != target:
    inc(i)

  arr[n - 1] = originalLast # Restore original last element
  displayElements(arr, "Restored")

  if i < n - 1: # Target found in the main part of the array
    result = i
  elif i == n - 1: # Loop stopped at the sentinel position
    if originalLast == target: # Target was the original last element
      result = n - 1
    else: # Target was not found in the original array
      result = -1

  return result

# Example usage
var numbers = @[5, 3, 8, 4, 2]

echo findNumber(numbers, 4) # Output: 3
echo findNumber(numbers, 7) # Output: -1
echo findNumber(numbers, 2) # Output: 4

var letters = @["a", "b", "c", "j"]
echo findNumber(letters, "c")
