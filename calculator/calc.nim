import strutils, std/[terminal]

type
  Op* = enum
    Add, Sub, Mul, Div, Reset, Clear, Help, Quit, Bad, MS, MR, MClear, MAdd
  CalculatorState* = object
    result*: float
    memory*: float

proc parseOp*(s: string): Op =
  return case s.toLower()
  of "+": Add
  of "-": Sub
  of "*": Mul
  of "/": Div
  of "r", "reset": Reset
  of "c", "clear": Clear
  of "h", "help": Help
  of "q", "quit": Quit
  of "ms": MS
  of "mr": MR
  of "mc": MClear
  of "m+": MAdd
  else: Bad


proc banner() =
  styledEcho styleBright, fgCyan:
    """--- REPL Calculator ---

Usage:
  Enter an operator (+, -, *, /) followed by a number to update the result.
  Example: '+ 10' or '/ 2'

Commands:
  h, help    : Show this help message
  r, reset   : Reset the current result to 0.
  c, clear   : Reset both the result and memory to 0.
  ms         : Store the current result in memory.
  mr         : Recall the value from memory to the current result.
  m+         : Add the current result to the value in memory.
  mc         : Clear the memory.
  q, quit    : Exit the program."""

proc prompt(): string = "> "

proc processLine*(state: var CalculatorState, line: string): string =
  ## Processes a single line of input, updating the calculator state.
  ## Returns a message string (e.g., for errors) or an empty string.
  ## A special "SHOW_HELP" string is returned for the help command.
  if line.len == 0: return ""

  let parts = line.split()
  if parts.len == 0: return ""

  let op = parseOp(parts[0])

  case op
  of Add, Sub, Mul, Div:
    if parts.len < 2:
      return "Error: operator '" & parts[0] & "' requires a number."
    var num: float
    try:
      num = parseFloat(parts[1])
    except ValueError:
      return "Error: invalid number '" & parts[1] & "'"

    case op
    of Add: state.result += num
    of Sub: state.result -= num
    of Mul: state.result *= num
    of Div:
      if num == 0.0:
        return "Error: division by zero"
      state.result /= num
    else: discard
  of Reset:
    state.result = 0.0
  of MS:
    state.memory = state.result
  of MR:
    state.result = state.memory
  of MClear:
    state.memory = 0.0
  of MAdd:
    state.memory += state.result
  of Clear:
    state.result = 0.0
    state.memory = 0.0
  of Help:
    return "SHOW_HELP"
  of Quit:
    # The main loop handles quitting.
    return ""
  of Bad:
    return "Invalid input: '" & line & "'. Type 'h' or 'help' for usage."

  return "" # No message

proc runCalc() =
  var state = CalculatorState(result: 0.0, memory: 0.0)
  banner()
  while true:
    stdout.write "Current Result: ", state.result
    if state.memory != 0.0: stdout.write "  [Memory: ", state.memory, "]"
    stdout.write "\n"
    stdout.write(prompt())
    stdout.flushFile()

    let line = stdin.readLine.strip
    if line.toLower() in ["q", "quit"]:
      break

    let msg = processLine(state, line)

    if msg == "SHOW_HELP":
      banner()
    elif msg.len > 0:
      echo msg

when isMainModule:
  runCalc()

