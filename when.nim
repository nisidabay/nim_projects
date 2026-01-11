# Nim
#
# The "when" statement is like "if.

when system.hostOS == "windows":
  echo "running on Windows!"
elif system.hostOS == "linux":
  echo "running on Linux!"
elif system.hostOS == "macosx":
  echo "running on MacOs"
else:
  echo "unknown operating system"
