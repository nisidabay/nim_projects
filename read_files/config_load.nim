import std/os

const ConfigFile = "app_config.ini"

# 1. Create a dummy file for the demonstration
writeFile(ConfigFile, "[General]\nversion=1.0\ndebug=true")

# 2. Read the file safely
if fileExists(ConfigFile):
  try:
    let content = readFile(ConfigFile)
    echo "📂 Loaded Configuration:"
    echo "------------------------"
    echo content
  except IOError:
    echo "❌ File could not be read (permission error)."
else:
  echo "❌ Config file not found."

# Cleanup
removeFile(ConfigFile)
