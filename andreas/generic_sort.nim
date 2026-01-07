import strutils

# Generic function to sort a sequence of any type
proc sort[T](arr: var openArray[T]) =
    let n = arr.len
    for i in 0..n-2:
        for j in 0..n-2-i:
            if arr[j] > arr[j+1]:
                (arr[j], arr[j+1]) = (arr[j+1], arr[j])

# Example usage:
var ints: seq[int] = @[64, 34, 25, 12, 22, 11, 90]
sort(ints)
echo "Sorted integers: " & ints.join(" |")

var strs: seq[string] = @["banana", "apple", "cherry", "date"]
sort(strs)
echo "Sorted strings: " & strs.join(" |")

var floats: seq[float] = @[3.14, 2.71, 1.41, 4.67]
sort(floats)
echo "Sorted floats: " & floats.join(" |")
