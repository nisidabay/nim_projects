# Nim
#
# parse enums

import std/strutils

type
  ProcessState {.pure.} = enum
    Initializing, Running, Paused, Terminated

proc handleState(s: ProcessState) =
  case s
  of ProcessState.Initializing: echo "Booting up..."
  of ProcessState.Running: echo "All systems nominal."
  of ProcessState.Paused: echo "Waiting..."
  of ProcessState.Terminated: echo "Ded."
  # No else! If we add 'Crashed', we want this to fail compilation.

proc safeParse(input: string): ProcessState =
  try:
    result = parseEnum[ProcessState](input)
  except ValueError:
    # Fallback or strict error handling
    echo "⚠️ Unknown state '", input, "'. Defaulting to Terminated."
    result = ProcessState.Terminated

# --- Main Runtime ---
let config = "Running"
let state = safeParse(config)
handleState(state)
