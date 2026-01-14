# Nim
#
# Errors examples

import tables

type ConfigDefect = object of Defect

proc loadConfig(val: int) =
  if val == 0:
    raise newException(ConfigDefect, "Developer error: val is 0")
  elif val < 0:
    raise newException(ValueError, "User error: negative value")

# Example of IOError
proc openFile(filename: string) =
  if filename == "":
    raise newException(IOError, "File not found")

# Example of KeyError
proc findInMap(key: string, data: Table[string, string]) =
  if not data.hasKey(key):
    raise newException(KeyError, "Key not found: " & key)

try:
  loadConfig(0)
except ValueError as e:
  echo e.msg
except ConfigDefect as e:
  echo e.msg

try:
  openFile("")
except IOError as e:
  echo e.msg

try:
  var data = initTable[string, string]()
  findInMap("nonexistent", data)
except KeyError as e:
  echo e.msg

