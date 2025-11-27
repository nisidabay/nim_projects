import std/[os, strutils, terminal, strformat]

proc createDirIfNotExists*(dir: string) =
  if not dirExists(dir):
    createDir(dir)

proc sanitizeFilename*(filename: string): string =
  result = filename
  const invalidChars = {'\\', '/', ':', '*', '?', '"', '<', '>', '|'}

  # You must loop through the set, as 'replace' does not accept a set
  for c in invalidChars:
    result = result.replace(c, '_') # This calls replace(string, char, char)

  if result.len > 200:
    result = result[0..199]

proc formatDuration*(seconds: int): string =
  # CHANGED: Expanded to include hours
  let hours = seconds div 3600
  let minutes = (seconds mod 3600) div 60
  let remainingSeconds = seconds mod 60

  if hours > 0:
    result = &"{hours}:{minutes:02d}:{remainingSeconds:02d}"
  else:
    result = &"{minutes}:{remainingSeconds:02d}"

proc formatFileSize*(bytes: int64): string =
  const units = ["B", "KB", "MB", "GB"]
  var size = bytes.float
  var unitIndex = 0

  # CHANGED: Switched from > to >= to correctly handle exact 1024 values
  while size >= 1024.0 and unitIndex < units.high:
    size = size / 1024
    unitIndex.inc

  result = &"{size:.2f} {units[unitIndex]}"

# --- Colored output procedures (Unchanged) ---

proc printSuccess*(msg: string) =
  setForegroundColor(fgGreen)
  echo "✓ ", msg
  resetAttributes()

proc printError*(msg: string) =
  setForegroundColor(fgRed)
  echo "✗ ", msg
  resetAttributes()

proc printWarning*(msg: string) =
  setForegroundColor(fgYellow)
  echo "⚠ ", msg
  resetAttributes()

proc printInfo*(msg: string) =
  setForegroundColor(fgCyan)
  echo "ℹ ", msg
  resetAttributes()

proc printProgress*(current, total: int, message: string = "") =
  let percentage = if total > 0: (current.float / total.float * 100.0) else: 0.0
  setForegroundColor(fgBlue)
  write stdout, &"\r[{current}/{total}] {percentage:.1f}% {message}"
  if current >= total:
    echo ""
  resetAttributes()
  flushFile(stdout)
