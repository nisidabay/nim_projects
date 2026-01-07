# Nim
#
# Usage of set
type
  Permission = enum
    Read, Write, Execute, Sudo

# 1. Creation: Start with a basic set
var myPerms: set[Permission] = {Read, Write}

echo "--- Initial Set ---"
echo myPerms

# 2. Adding items (Inclusion)
# 'incl' adds an item if it's not already there.
incl(myPerms, Execute)
incl(myPerms, Sudo)
echo "\n--- After adding Execute and Sudo ---"
echo myPerms

# 3. Removing items (Exclusion)
# 'excl' removes an item.
excl(myPerms, Sudo)
echo "\n--- After removing Sudo ---"
echo myPerms

# 4. Checking existence (Membership)
# Check if a specific item is inside the set using 'in'
echo "\n--- Check if we have Sudo ---"
if Sudo in myPerms:
  echo "You are an admin."
else:
  echo "You are not an admin."

# Define some other sets to compare against
let
  adminPerms = {Read, Write, Execute, Sudo}
  readOnly = {Read}

# 5. Intersection (*)
# Finds items that appear in BOTH sets.
# (Common ground between myPerms and adminPerms)
let commonItems = myPerms * adminPerms
echo "\n--- Intersection (Common items) ---"
echo commonItems

# 6. Union (+)
# Combines two sets together (without duplicates).
let combinedPerms = myPerms + readOnly
echo "\n--- Union (Combined items) ---"
echo combinedPerms

# 7. Difference (-)
# Removes items found in the second set from the first set.
# (What do I have that ReadOnly does NOT have?)
let uniqueToMe = myPerms - readOnly
echo "\n--- Difference (My perms minus ReadOnly) ---"
echo uniqueToMe

# 8. Equality and Subsets
echo "\n--- Comparisons ---"

# Check if two sets are exactly the same
if myPerms == adminPerms:
  echo "Sets are identical."
else:
  echo "Sets are different."

# Check if myPerms is a subset (<=) of adminPerms
# (Is every item I have also inside adminPerms?)
if myPerms <= adminPerms:
  echo "myPerms is a subset of adminPerms."

# 9. Cardinality
# Counts how many items are in the set.
echo "\n--- Count ---"
echo "Number of items in 'myPerms': ", card(myPerms)
