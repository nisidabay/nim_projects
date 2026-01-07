# Nim
#
# Use of normalize
import strutils

# lower case and remove any '_'.
echo normalize("Foo_Bar")
# lower case, except the first char, and remove any '_'.
echo nimIdentNormalize("Foo Bar")
