let s1 = {'a', 'b', 'c', 'e'}
echo "set s1 = ", s1
let s2 = {'a', 'c', 'e'}
echo "set s2 = ", s2

let union = s1 + s2
echo "union s1 + s2: all without duplicates = ", union

let intersection = s1 * s2
echo "intersection s1 * s2: only common without duplicates = ", intersection

let difference = s1 - s2
echo "difference s1 - s2: only what's in s1 that's not in s2 = ", difference

let subset1 = s1 <= s2
echo "subset s1 <= s2: Is s1 a subset of s2? = ", subset1

let subset2 = s2 <= s1
echo "subset s2 <= s1: Is s2 a subset of s1? = ", subset2

