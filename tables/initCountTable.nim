# Nim
#
# initCountTable. Creates a new count table.

import std/tables

var ips = initCountTable[string]()
ips.inc("127.0.0.1")
ips.inc("127.0.0.2")
ips.inc("127.0.0.3")
ips.inc("127.0.0.1")

echo ips.largest()
