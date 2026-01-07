# Nim
#
# Create loggers: File logger, changes every 5 lines and a console logger
# file logger gets the default fmtStr format and the lvlWarn messages.
# Console logger creates its own format and gets from lvlDebug and above
# messages.

import std/[logging]

# Configure logging
proc setupLogging(logName: string, threshold: Level,
                  fmtStr = "[$time] - $appname, $levelname: ") =

  # File logger gets some default values
  let fileLogger = newRollingFileLogger(logName, mode = fmAppend,
      fmtStr = fmtStr, levelThreshold = threshold, maxLines = 5)
  addHandler(fileLogger)

  # Console logger remains explicitly Debug + custom format
  let consoleLogger = newConsoleLogger(fmtStr = "[$time] - $levelname: ",
      levelThreshold = lvlDebug)
  addHandler(consoleLogger)

# Run the configuration
setupLogging("app.log", lvlWarn)

# Test the loggers
debug("1. Debug message.")
info("2. Info message.")
warn("3. Warning message.")
