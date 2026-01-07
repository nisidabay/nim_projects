# Nim
#
# use of fold in a sequence from left to right, returning the accumulation.

import sequtils

echo(@[14, 35, -7, 47, 98].foldl(min(a, b)))
echo(@[14, 35, -7, 47, 98].foldl(max(a, b)))
