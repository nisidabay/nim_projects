import std/tables

var inventory = {"Gold": 50, "Wood": 10}.toTable

echo "Before: ", inventory

inventory.mgetOrPut("Gold", 0) += 20
inventory.mgetOrPut("Diamond", 0) += 1

echo "After: ", inventory
