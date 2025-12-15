# tests/test_calculator.nim
#
# This file contains the unit tests for the simple calculator.
# To run these tests, execute the following command in your terminal:
#
#   nim compile --run tests/test_calculator.nim
#
# We will test the two core pieces of logic we exported from calc.nim:
# 1. `parseOp`: To ensure it correctly identifies commands.
# 2. `processLine`: To ensure it correctly updates the calculator's state.

import unittest
from ../calc import parseOp, Op, processLine, CalculatorState

suite "Simple Calculator Logic":

  test "parseOp should correctly identify all operations and commands":
    check: parseOp("+") == Add
    check: parseOp("-") == Sub
    check: parseOp("*") == Mul
    check: parseOp("/") == Div
    check: parseOp("r") == Reset
    check: parseOp("reset") == Reset # Check alias
    check: parseOp("c") == Clear
    check: parseOp("clear") == Clear # Check alias
    check: parseOp("h") == Help
    check: parseOp("help") == Help   # Check alias
    check: parseOp("q") == Quit
    check: parseOp("quit") == Quit   # Check alias
    check: parseOp("ms") == MS
    check: parseOp("mr") == MR
    check: parseOp("m+") == MAdd
    check: parseOp("mc") == MClear
    check: parseOp("H") == Help       # Check case-insensitivity

  test "processLine should perform calculations correctly":
    var state = CalculatorState(result: 10.0, memory: 0.0)

    discard processLine(state, "+ 5")
    check: state.result == 15.0

    discard processLine(state, "* 2")
    check: state.result == 30.0

    discard processLine(state, "- 20")
    check: state.result == 10.0

    discard processLine(state, "/ 4")
    check: state.result == 2.5

  test "processLine should handle commands correctly":
    var state = CalculatorState(result: 100.0, memory: 50.0)

    # Test Reset
    discard processLine(state, "reset")
    check: state.result == 0.0

    # Test Clear
    discard processLine(state, "clear")
    check: state.result == 0.0
    check: state.memory == 0.0

  test "processLine should handle memory commands correctly":
    var state = CalculatorState(result: 10.0, memory: 5.0)
    
    # Test MS (Memory Store)
    discard processLine(state, "ms")
    check: state.result == 10.0
    check: state.memory == 10.0

    # Test MR (Memory Recall)
    state.result = 20.0
    discard processLine(state, "mr")
    check: state.result == 10.0
    
    # Test M+ (Memory Add)
    state.result = 3.0
    discard processLine(state, "m+")
    check: state.memory == 13.0

    # Test MC (Memory Clear)
    discard processLine(state, "mc")
    check: state.memory == 0.0

  test "processLine should return correct messages":
    var state = CalculatorState(result: 10.0, memory: 0.0)

    check: processLine(state, "h") == "SHOW_HELP"
    check: processLine(state, "foo") == "Invalid input: 'foo'. Type 'h' or 'help' for usage."
    check: processLine(state, "+") == "Error: operator '+' requires a number."
    check: processLine(state, "/ 0") == "Error: division by zero"
    check: processLine(state, "* foo") == "Error: invalid number 'foo'"
