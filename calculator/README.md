# Simple REPL Calculator in Nim

This is a simple, interactive REPL (Read-Eval-Print Loop) calculator written in
the Nim programming language.

It supports basic arithmetic operations and maintains a short-term memory of
the last result.

## Project Structure

```
.
├── calc.nim
└── tests
    └── test_calculator.nim
```

- `calc.nim`: The main application file containing all the calculator's logic
and the user interface.
- `tests/test_calculator.nim`: The unit test suite for the calculator.

## How to Use

1.  **Compile and Run the Calculator:**

    Open your terminal and run the following command:
    ```sh
    nim compile --run calc.nim
    ```

2.  **Using the REPL:**

    Once the calculator starts, you can enter commands or operations.

    **Usage:**
    Enter an operator (`+`, `-`, `*`, `/`) followed by a number to update the result.
    Example: `+ 10` or `/ 2`

    **Commands:**
    - `h, help`: Show the help message.
    - `r, reset`: Reset the current result to 0.
    - `c, clear`: Reset both the result and memory to 0.
    - `ms`: Store the current result in memory.
    - `mr`: Recall the value from memory to the current result.
    - `m+`: Add the current result to the value in memory.
    - `mc`: Clear the memory.
    - `q, quit`: Exit the program.

## How to Run Tests

To verify that the calculator's logic is working correctly, you can run the
provided unit test suite.

```sh
nim compile --run tests/test_calculator.nim
```

A successful run will show that all test cases have passed.
