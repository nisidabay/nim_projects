# The "when" statement is like "if," but it has these special rules: It uses
 # only simple answers (like numbers or fixed choices) and doesn't start a new
 # place where you can use different names for things. Only one of its answers
 # can be true at the same time, so the computer only does what that answer
 # says. This is helpful if you need to follow different instructions on
 # computers with different features.
 #
when system.hostOS == "windows":
  echo "running on Windows!"
elif system.hostOS == "linux":
  echo "running on Linux!"
elif system.hostOS == "macosx":
  echo "running on MacOs"
else:
  echo "unknown operating system"
