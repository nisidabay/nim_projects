# Nim - defining a hash for a type object

import tables, hashes

type
  Dog = object
    name: string

# Hash procedure for custom types
proc hash(x: Dog): Hash =
  result = x.name.hash # Create the hash
  result = !$result # Finish the computation of the hash value

var dogOwners = initTable[Dog, string]()
dogOwners[Dog(name: "Charlie")] = "John"

for key, value in dogOwners.pairs:
  echo "Dog name: ", key.name, " Owner: ", value

