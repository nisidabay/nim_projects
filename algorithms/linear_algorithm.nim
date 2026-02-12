# Nim - linearSearch algorrithm

proc linearSearch(slice: seq[int], length: int, valueToSearch: int): int =
    for i in 0..<length:
        if slice[i] == valueToSearch:
            return i
    return -1

# Example usage:
let slice: seq[int] = @[34, 23, 12, 98, 76]
let length = 5
let valueToSearch = 98

let result = linearSearch(slice, length, valueToSearch)
if result != -1:
    echo "Value found at index: ", result
else:
    echo "Value not found in the array"
