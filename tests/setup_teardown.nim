# Nim
#
# Setup/Teardown Suite
import unittest, os, times

suite "File Operations with Setup/Teardown":
  # Variables must be declared at the suite level to be visible
  var testFile: string
  var tempDir: string
  
  setup:
    # 🛠️ Setup / Tooling: Runs before EACH test
    tempDir = "test_temp_" & $getTime().toUnix()
    createDir(tempDir)
    testFile = joinPath(tempDir, "test_data.txt")
    writeFile(testFile, "initial content")
  
  teardown:
    # 🛠️ Setup / Tooling: Runs after EACH test
    # This is where we clean up the mess we made.
    removeFile(testFile)
    removeDir(tempDir)
  
  test "file reading":
    # The file exists here, thanks to setup.
    let content = readFile(testFile)
    check(content == "initial content")
  
  test "file writing":
    # The file will be deleted by teardown, ensuring isolation.
    writeFile(testFile, "new content")
    let content = readFile(testFile)
    check(content == "new content")
