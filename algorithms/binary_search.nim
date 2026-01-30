# Binary search function in Nim
proc binarySearch(arr: seq[int], target: int): int =
  var left, right: int
  left = 0
  right = arr.len - 1

  while left <= right:
    var mid = (left + right) div 2
    if arr[mid] == target:
      return mid
    elif arr[mid] < target:
      left = mid + 1
    else:
      right = mid - 1

  return -1

# Example usage
var sortedArray = @[1, 3, 5, 7, 9, 11, 13]
let result = binarySearch(sortedArray, 7)
echo "Index of 7: " & $result

# Test with a value not in array
let result2 = binarySearch(sortedArray, 6)
echo "Index of 6: " & $result2

