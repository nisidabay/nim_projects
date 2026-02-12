# Nim - Handle configuration files

import std/[os, strutils]

# Expected config file structure
type
  Config = object
    model: string
    editor: string
    pager: string

# Default values in case 'path' does not exists
const
  DefaultModel = "ministral-3:8b"
  DefaultEditor = "nvim"
  DefaultPager = "nvim"

proc loadConfigDemo(path: string): Config =
  # Step 1: Set Defaults
  result.model = DefaultModel
  result.editor = DefaultEditor
  result.pager = DefaultPager

  echo "--- 1. Initial Defaults ---"
  echo "Model: ", result.model
  echo "Editor: ", result.editor
  echo "Pager: ", result.pager
  echo ""

  if fileExists(path):
    echo "--- 2. Parsing File: ", path, " ---"
    let content = readFile(path)

    for line in content.splitLines():
      let trimmed = line.strip()

      # Logic: Skip comments and empty lines
      if trimmed.len == 0 or trimmed.startsWith("#"):
        echo "[Skipping] ", line
        continue

      if trimmed.contains("="):
        let parts = trimmed.split("=", 1)
        let key = parts[0].strip()
        var value = parts[1].strip()

        # Logic: Remove quotes
        if value.startsWith("\"") and value.endsWith("\""):
          value = value[1..^2]

        echo "[Found Pair] Key: ", key, " | Value: ", value

        case key.toLowerAscii()
        of "model":
          result.model = value
        of "editor":
          result.editor = value
        of "pager":
          result.pager = value
        else:
          # This is option is discarded
          echo "  -> Key '", key, "' not recognized. Discarding."

    echo ""
  else:
    echo "--- File not found, keeping defaults ---"

# --- Run the Demo ---
let currentDir = getCurrentDir()
let fakeFile = currentDir / "fake_ollama_explain.conf"

let finalConfig = loadConfigDemo(fakeFile)

echo "--- 3. Final Result ---"
echo "Model: ", finalConfig.model
echo "Editor: ", finalConfig.editor
echo "Pager: ", finalConfig.pager
