import std/tables

type Cache = TableRef[string, string]
var counter = 0

proc loadData(cache: Cache, query: string): string =
  if cache.hasKey(query):
    echo "✓ HIT: Found in cache"
    return "Cached: " & cache[query]
  else:
    inc counter
    echo "✗ MISS: Cached value"
    let computedResult = $query & " = " & $counter
    cache[query] = computedResult
    return computedResult

var appCache: Cache = newTable[string, string]()

echo loadData(appCache, "user1") # CACHE MISS - returns #1
echo loadData(appCache, "user1") # CACHE HIT - returns #1 (same as above)
echo loadData(appCache, "user2") # CACHE MISS - returns #2 (different!)
