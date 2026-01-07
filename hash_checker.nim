import os
import std/md5
import std/sha1
import std/strformat

proc makeHashes*(filePaths: seq[string]) =
  for filePath in filePaths:
    if not fileExists(filePath):
      echo "File ", filePath, " does not exist."
      continue

    var content: string

    try:
      content = readFile(filePath)
    except IOError as e:
      echo fmt"Error reading file:  {filePath}, {e.msg}"
      continue

    # 1. Get MD5 hash
    # The 'toMD5' proc returns an 'MD5Digest' object.
    # The '$' operator converts the digest to a hex string.
    let md5sum = $toMD5(content)
    echo "MD5(", filePath, ") = ", md5sum

    # 2. Get SHA1 hash
    # The 'secureHash' proc returns a 'SecureHash' object.
    # The '$' operator converts that digest to a hex string.
    let sha1sum = $secureHash(content)
    echo "SHA1(", filePath, ") = ", sha1sum

proc getString(hash: string) =
  let originalString = getMD5(hash)

when isMainModule:
  if paramCount() == 0:
    echo "Usage: hash_checker <file1> [file2] ..."
  else:
    let filePaths = commandLineParams()
    makeHashes(filePaths)
