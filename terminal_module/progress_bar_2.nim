import std/terminal, std/strutils, std/os

type Download = object
  name: string
  progress: range[0..100]

proc renderProgress(downloads: seq[Download]) =
  hideCursor() # Prevent flicker
  defer: showCursor()

  # Move cursor up to the beginning of the block of progress bars to redraw
  cursorUp(downloads.len)

  for i, dl in downloads:
    eraseLine()
    stdout.write("\r") # Move to beginning of line

    let barWidth = 30
    let filled = (dl.progress * barWidth) div 100
    let bar = '[' & '#'.repeat(filled) & ' '.repeat(barWidth - filled) & ']'

    stdout.styledWrite(
      fgCyan, alignLeft(dl.name, 15),
      resetStyle, " ",
      fgYellow, bar,
      resetStyle, " ",
      fgGreen, align($dl.progress, 3), "%"
    )
    stdout.write("\n") # Move to the next line after printing this bar


# Usage simulation
when isMainModule:
  var downloads = @[
    Download(name: "archive.zip", progress: 75),
    Download(name: "image.png", progress: 30),
    Download(name: "data.json", progress: 90)
  ]

  echo "Starting parallel downloads..."
  for _ in 0..<downloads.len: # Print empty lines as placeholders for the first render
    echo ""

  # Simulate progress
  for iter in 0..100: # Simulate 100 steps of progress
    # Update progress for each download
    for i in 0..<downloads.len:
      downloads[i].progress = min(100, downloads[i].progress + (if i == 0: 1 else: 2)) # Vary speeds

    # Initial render: move cursor up to the first placeholder line
    # If iter is 0, this is the first real render
    # Otherwise, renderProgress handles moving the cursor up
    if iter == 0:
      cursorUp(downloads.len)
    renderProgress(downloads)
    sleep(50) # Small delay to see the updates

  echo "\nDownloads complete! Press Enter to exit."
  discard stdin.readLine()

