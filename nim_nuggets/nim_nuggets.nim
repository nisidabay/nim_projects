# Nim
#
# nim_nuggets refresher utility to learn Nim

import std/strutils
import std/strformat
import std/random
import std/times
import std/terminal
import std/os
import std/osproc

# --- Configuration ---
const Version = "1.0.0"
const Separator = "•••"
const BaseDir = "bin"
const AppDirName = "nim_nuggets"
const DefaultLinkName = "default_nugget.txt"
const Editor = getEnv("EDITOR", "nvim")

# --- Types ---
type
  SearchResult = object
    topic: string
    snippet: string
    preview: string

# --- Helper for printPanel ---
#   text: The multi-line string to analyze.
# Returns: The integer length of the longest line.
proc longestLineLength(text: string): int =
  var maxLen = 0
  for line in text.splitLines():
    if line.len > maxLen:
      maxLen = line.len
  result = maxLen

# --- Print a fancy panel around text ---
## Prints a string of text inside a decorative, colored panel in the terminal.
## Params:
##   text: The main content to display inside the panel.
##   title: An optional title to display in the panel's top border.
##   color: The foreground color for the main text.
##   borderColor: The foreground color for the panel's border.
proc printPanel(text: string, title: string = "",
    color: ForegroundColor = fgYellow, borderColor: ForegroundColor = fgBlue) =
  let contentMaxLen = longestLineLength(text)
  let titleWidth = if title.len > 0: title.len + 2 else: 0

  # Panel inner width should fit content or title, whichever is longer
  # Add 2 for left/right padding (1 space on each side)
  let innerWidth = max(contentMaxLen + 2, titleWidth + 2)

  let lines = text.splitLines()

  # Top Border
  stdout.setForegroundColor(borderColor, true)
  stdout.write("╭")
  if title.len > 0:
    stdout.write(" ", title, " ")
    stdout.write(repeat("─", innerWidth - titleWidth))
  else:
    stdout.write(repeat("─", innerWidth))
  stdout.write("╮\n")

  # Body - print each line with proper padding and borders
  for line in lines:
    stdout.setForegroundColor(borderColor, true)
    stdout.write("│")
    stdout.resetAttributes()
    stdout.setForegroundColor(color, true)

    # Print line with padding to match panel width
    stdout.write(" ", line)
    let rightPadding = innerWidth - line.len - 1 # -1 for the left space we just added
    stdout.write(repeat(" ", rightPadding))

    stdout.resetAttributes()
    stdout.setForegroundColor(borderColor, true)
    stdout.write("│\n")

  # Bottom border
  stdout.setForegroundColor(borderColor, true)
  stdout.write("╰")
  stdout.write(repeat("─", innerWidth))
  stdout.write("╯\n")
  stdout.resetAttributes()

# --- Print error panel ---
## Displays an error message in a standardized red panel.
## Params:
##   msg: The error message string to display.
proc printError(msg: string) =
  printPanel(fmt"{msg}", "Error", fgRed, fgRed)

# --- Print success panel ---
## Displays a success message in a standardized green and blue panel.
## Params:
##   msg: The success message string to display.
proc printSuccess(msg: string) =
  printPanel(fmt"{msg}", "Success", fgGreen, fgBlue)

# --- System Helpers ---
## Gets the absolute path to the nuggets directory (~/bin/nim_nuggets).
## Creates the directory if it does not already exist.
## Returns: The string path to the nuggets directory.
proc getNuggetsDir(): string =
  result = joinPath(getHomeDir(), BaseDir, AppDirName)
  if not dirExists(result):
    createDir(result)

## Gets the absolute path for the default nugget symlink.
## This file acts as a pointer to the currently active nugget topic.
## Returns: The string path for the default_nugget.txt link file.
proc getDefaultLinkPath(): string =
  joinPath(getNuggetsDir(), DefaultLinkName)

## Gets the path of the currently active nugget file.
## It resolves the symlink that points to the active topic.
## Returns: The string path to the active nugget file, or an empty string if none.
proc getActiveNuggetPath(): string =
  let link = getDefaultLinkPath()
  # check if symlink or regular file exists
  if symlinkExists(link) or fileExists(link):
    try:
      return expandSymlink(link)
    except OSError:
      # If it's a regular file (not symlink), return it directly
      return link
  return ""

## Sets the active nugget topic.
## It removes any existing link and creates a new symlink to the target path.
## Params:
##   targetPath: The absolute path to the nugget file to set as active.
proc setActiveNugget(targetPath: string) =
  let link = getDefaultLinkPath()
  if symlinkExists(link) or fileExists(link):
    removeFile(link)

  createSymlink(targetPath, link)
  printSuccess(fmt"Switched topic to: {extractFilename(targetPath)}")

# --- FZF Integration ---
## Runs the fzf command-line fuzzy finder with a given list of options.
## Params:
##   options: A sequence of strings to use as the choices in fzf.
##   prompt: The prompt to display within the fzf interface.
## Returns: The item selected by the user, or an empty string if nothing was selected.
proc runFzf(options: seq[string], prompt: string): string =
  if options.len == 0:
    return ""

  let input = options.join("\n")
  let tempOutput = getTempDir() / fmt"fzf_output_{getTime().toUnix}.txt"

  try:
    # Build fzf command, piping options via printf to fzf's stdin.
    # The selected output is redirected to a temporary file.
    let fzfPart = fmt"fzf --prompt {quoteShell(prompt)} --height 40% --layout reverse --border"
    let cmd = fmt"printf '%s' {quoteShell(input)} | {fzfPart} > {quoteShell(tempOutput)}"

    let exitCode = execCmd(cmd)

    # Read result if successful
    if exitCode == 0 and fileExists(tempOutput):
      result = readFile(tempOutput).strip()
    else:
      result = ""

  finally:
    # Cleanup temp file
    if fileExists(tempOutput):
      removeFile(tempOutput)

# --- Core Logic ---
## Scans the nuggets directory for all available topic files.
## Returns: A sequence of strings, where each string is a nugget filename (e.g., "topic.txt").
proc getAllTopics(): seq[string] =
  let directory = getNuggetsDir()
  for kind, path in walkDir(directory):
    if kind == pcFile and path.endsWith(".txt") and extractFilename(path) != DefaultLinkName:
      result.add(extractFilename(path))
  result

## Reads a nugget file and splits its content into a sequence of snippets.
## Snippets in the file are delimited by the Separator constant ("•••").
## Params:
##   path: The path to the nugget file to load.
## Returns: A sequence of strings, where each string is a snippet.
proc loadSnippets(path: string): seq[string] =
  if not fileExists(path): return @[]
  let content = readFile(path)

  # Split by "•••"
  for raw in content.split(Separator):
    let cleaned = raw.strip()
    if cleaned.len > 0:
      result.add(cleaned)

# --- Search Helper Functions ---
## Gets a search query.
## Returns the provided search term, or if it's empty, prompts the user to enter one.
## Params:
##   searchTerm: The search term passed via command line, if any.
## Returns: The search term to be used for the search.
proc getSearchQuery(searchTerm: string): string =
  if searchTerm.len > 0:
    return searchTerm

  stdout.write("Enter search term: ")
  result = stdin.readLine().strip()

## Creates a short, single-line preview from a snippet.
## It takes the first line and truncates it if it exceeds a max length.
## Params:
##   snippet: The full snippet text.
##   maxLen: The maximum length of the preview string.
## Returns: A truncated, single-line preview of the snippet.
proc createSnippetPreview(snippet: string, maxLen: int = 60): string =
  let lines = snippet.splitLines()
  let firstLine = if lines.len > 0: lines[0] else: snippet

  if firstLine.len > maxLen:
    result = firstLine[0..maxLen-1] & "..."
  else:
    result = firstLine

## Searches all topics for snippets containing a query.
## The search is case-insensitive.
## Params:
##   query: The term to search for within snippets.
## Returns: A sequence of `SearchResult` objects for all matching snippets.
proc searchAllTopics(query: string): seq[SearchResult] =
  let topics = getAllTopics()

  for topicFile in topics:
    let topicPath = joinPath(getNuggetsDir(), topicFile)
    let snippets = loadSnippets(topicPath)
    let topicName = topicFile.replace(".txt", "")

    for snippet in snippets:
      if snippet.toLower().contains(query.toLower()):
        result.add(SearchResult(
          topic: topicName,
          snippet: snippet,
          preview: createSnippetPreview(snippet)
        ))

## Formats a list of search results for display in fzf.
## Each line is formatted as: "index | [topic] preview..."
## Params:
##   results: The sequence of `SearchResult` objects to format.
## Returns: A sequence of strings ready to be displayed by fzf.
proc formatSearchResultsForFzf(results: seq[SearchResult]): seq[string] =
  for i, res in pairs(results):
    result.add(fmt"{i} | [{res.topic}] {res.preview}")

## Extracts the result index from a line selected in fzf.
## It parses the integer that appears before the first " | ".
## Params:
##   selection: The raw string line selected by the user in fzf.
## Returns: The zero-based integer index of the selection, or -1 on parsing failure.
proc parseSearchSelection(selection: string): int =
  let parts = selection.split(" | ")
  if parts.len > 0:
    try:
      return parseInt(parts[0])
    except ValueError:
      return -1
  return -1

## Opens a topic file in the editor defined by the EDITOR environment variable.
## Params:
##   topicName: The name of the topic to edit (e.g., "my_topic").
proc openTopicInEditor(topicName: string) =
  let nuggetPath = joinPath(getNuggetsDir(), topicName & ".txt")
  let exitCode = execCmd(fmt"{Editor} {quoteShell(nuggetPath)}")

  if exitCode == 0:
    printSuccess("Edited:" & fmt"Nugget ({nuggetPath}).")

## Manages the search result user interface flow.
## Displays search results in fzf, waits for user selection, and opens the
## selected snippet's topic in the editor.
## Params:
##   results: A sequence of `SearchResult` objects to display.
##   query: The original search query, used for the fzf prompt.
proc handleSearchResults(results: seq[SearchResult], query: string) =
  let options = formatSearchResultsForFzf(results)
  let selection = runFzf(options, fmt"Search: '{query}'")

  if selection.len == 0:
    return

  let id = parseSearchSelection(selection)

  if id >= 0 and id < results.len:
    printPanel(results[id].snippet, fmt"Found in: {results[id].topic}")
    openTopicInEditor(results[id].topic)
  else:
    printError("Invalid selection")

# --- Actions ---
## Lets the user change the active nugget topic using fzf.
proc changeTopic() =
  let topics = getAllTopics()
  if topics.len == 0:
    printError("No topics found.")
    return

  let selection = runFzf(topics, "Select Topic")
  if selection.len > 0:
    let fullPath = joinPath(getNuggetsDir(), selection)
    setActiveNugget(fullPath)

## Opens the currently active nugget file in the configured editor.
proc editNugget() =
  let current = getActiveNuggetPath()
  if current.len == 0:
    printError("No active topic selected. Use -c first.")
    return

  let exitCode = execCmd(fmt"nvim {quoteShell(current)}")
  if exitCode == 0:
    printSuccess("Nugget edited.")

## Creates a new nugget topic.
## Prompts the user for a new topic name, creates the corresponding file,
## and sets it as the active nugget.
proc newNugget() =
  stdout.write("Enter new topic name (no extension): ")
  let name = stdin.readLine().strip()
  if name.len == 0: return

  let filename = name & ".txt"
  let path = joinPath(getNuggetsDir(), filename)

  if fileExists(path):
    printError("Topic already exists.")
  else:
    # Initialize with the separator
    writeFile(path, fmt"{Separator} Initial Snippet")
    printSuccess(fmt"Created {filename}")
    setActiveNugget(path)

## Selects and displays a random snippet from the currently active nugget file.
proc randomSnippet() =
  let current = getActiveNuggetPath()
  if current.len == 0:
    printError("No active topic. Run with -c to select one.")
    return

  let snippets = loadSnippets(current)
  if snippets.len == 0:
    printError("Topic is empty.")
    return

  randomize()
  let snippet = sample(snippets)
  let topicName = current.extractFilename().replace(".txt", "")

  printPanel(snippet, fmt"Nugget: {topicName}")

## Prints a list of all available nugget topic files.
proc showAllSnippetFiles() =
  let snippetPath = getNuggetsDir()
  if snippetPath.isEmptyOrWhitespace:
    printError("No available nuggets.")

  printPanel("Available nuggets", "")
  for entry in walkDir(snippetPath):
    if entry.kind == pcFile and entry.path.endsWith(".txt"):
      let fileName = extractFileName(entry.path)
      echo fileName

## Lists all snippets from the current topic in fzf and displays the selection.
proc listSnippets() =
  let current = getActiveNuggetPath()
  if current.len == 0:
    printError("No active topic.")
    return

  let snippets = loadSnippets(current)
  var options: seq[string] = @[]

  for i, s in pairs(snippets):
    # Get the first line of the snippet to use as the title in FZF
    let lines = s.splitLines()
    let firstLine = if lines.len > 0: lines[0] else: "Empty"

    # Clean up the line for display (truncate if too long)
    let maxLen = if firstLine.len > 0: min(firstLine.len - 1, 70) else: 0
    let displayLine = if firstLine.len > 0:
                        firstLine[0 .. maxLen].replace("\n", " ")
                      else:
                        "Empty"
    options.add(fmt"{i} - {displayLine}")

  let selection = runFzf(options, "Browse Snippets")
  if selection.len > 0:
    let parts = selection.split(" - ")
    if parts.len > 0:
      try:
        let id = parseInt(parts[0])
        if id >= 0 and id < snippets.len:
          printPanel(snippets[id], "Selected Snippet")
      except ValueError:
        printError("Invalid selection")

## Searches for snippets across all topics.
## It takes an optional search term from the command line; if not provided,
## it prompts the user to enter one.
## Params:
##   searchTerm: An optional search term.
proc searchNuggets(searchTerm: string = "") =
  let query = getSearchQuery(searchTerm)

  if query.len == 0:
    printError("No search term provided.")
    return

  let topics = getAllTopics()
  if topics.len == 0:
    printError("No topics found.")
    return

  let results = searchAllTopics(query)

  if results.len == 0:
    printError(fmt"No snippets found containing '{query}'")
    return

  handleSearchResults(results, query)

## Merges the content of all nugget files into a single `ALL_NUGGETS.txt` file.
proc mergeNuggets() =
  let directory = getNuggetsDir()
  let outFile = joinPath(directory, "ALL_NUGGETS.txt")
  var allContent = ""

  for topic in getAllTopics():
    allContent.add(fmt"--- {topic} ---" & "\n")
    allContent.add(readFile(joinPath(directory, topic)))
    allContent.add("\n\n")

  writeFile(outFile, allContent)
  printSuccess("Merged all nuggets to ALL_NUGGETS.txt")

## Checks if the active topic has not been changed for more than a week.
## If it's been too long, it prints a reminder panel.
proc checkWeekly() =
  let link = getDefaultLinkPath()
  if not symlinkExists(link) and not fileExists(link): return

  try:
    # Use followSymlink = false to get the link's creation time,
    # not the target file's modification time.
    let info = getFileInfo(link, followSymlink = false)
    let currentTime = getTime()
    let diff = currentTime - info.lastWriteTime

    if inDays(diff) > 7:
      printPanel("It's been over a week since you changed topics. Time to rotate!",
          "Weekly Reminder", fgRed)
  except OSError:
    discard

# --- Main ---
## Prints the help message with all command-line options.
proc showHelp() =
  echo """
  Nim Nuggets - Kind of 'fortune' app for showing Nim snippets
  
  nuggets -c          Change nugget (fzf)
  nuggets -e          Edit current nugget (nvim)
  nuggets -l          List/Browse snippets in current nugget (fzf)
  nuggets -n          New nugget
  nuggets -m          Merge all nuggets
  nuggets -s [term]   Search for term across all nuggets
  nuggets -S          Show all available nuggets
  nuggets -R          Random Snippet (Default)
  nuggets -v          Show current version
  """

## The main entry point of the script.
## Parses command-line arguments and calls the appropriate action procedure.
proc main() =
  let params = commandLineParams()
  checkWeekly()

  if params.len == 0:
    randomSnippet()
    return

  case params[0]:
    of "-c": changeTopic()
    of "-e": editNugget()
    of "-n": newNugget()
    of "-l": listSnippets()
    of "-m": mergeNuggets()
    of "-s":
      if params.len > 1:
        # Search term provided as argument
        searchNuggets(params[1])
      else:
        # Prompt for search term
        searchNuggets()
    of "-S": showAllSnippetFiles()
    of "-R": randomSnippet()
    of "-h", "--help": showHelp()
    of "-v": echo Version
    else: randomSnippet()

when isMainModule:
  main()

