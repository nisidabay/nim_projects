import osproc, os, strformat

proc downloadVideo(url: string, outputPath: string = "downloads") =
  ## Downloads a YouTube video using yt-dlp
  try:
    echo &"Fetching video from {url}..."

    # Create output directory if it doesn't exist
    createDir(outputPath)

    # Construct yt-dlp command
    let cmd = &"yt-dlp -o {outputPath}/'%(title)s.%(ext)s' {url}"

    # Execute command
    let exitCode = execCmd(cmd)

    if exitCode == 0:
      echo "✅ Download successful!"
    else:
      echo "❌ Download failed"

  except Exception as e:
    echo &"❌ An error occurred: {e.msg}"

# Main program
when isMainModule:
  echo "--- Nim YouTube Downloader ---"
  let url = readLine(stdin).string.strip
  if url.len > 0:
    downloadVideo(url)
  else:
    echo "Please provide a valid URL"
