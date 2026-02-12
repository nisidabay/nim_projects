import std/streams

proc logToFile(msg: string) =
  var strm = newFileStream("server.log", fmAppend)

  defer: strm.close()

  try:
    if strm.isNil():
      stderr.writeLine("Error: Could not open log file!")
      return
    strm.writeLine(msg)
    strm.flush() # Ensure data is written to disk immediately.
  except Exception as e:
    stderr.writeLine("Error writing to log file: " & e.msg)
  # finally:
  #   if strm != nil:
  #     strm.close() # Close the stream even if an error occurred or it was never opened.

# Example usage of the logging function:
logToFile("[INFO] System online")
logToFile("[WARNING] Low battery")
logToFile("[ERROR] Kernel panic")
