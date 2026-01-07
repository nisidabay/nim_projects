# Nim
#
# Example of TableRef. This is a pointer not the whole table
import std/tables

# Use TableRef so the 'cache' is shared across proc calls
type Cache = TableRef[string, string]

proc loadData(cache: Cache, query: string): string =
  if cache.hasKey(query):
    echo "Hit: " & query
    return cache[query]

  echo "Miss: " & query
  let computedResult = "Result for " & query
  cache[query] = computedResult
  return computedResult

# Initialize the Reference Table
var appCache: Cache = newTable[string, string]()

discard loadData(appCache, "user:1") # Miss
discard loadData(appCache, "user:1") # Hit
discard loadData(appCache, "user:2") # Miss
