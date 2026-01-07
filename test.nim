
type
  Person = object
    ## Value type (allocated on stack)
    name: string
    age: int

proc getUsername(prompt: string = "Enter username: "): string =
  ## Uses the implicit 'result' variable.
  ## 'result' is initialized to the type's default value (empty string here).
  stdout.write prompt
  stdout.flushFile() # Ensure prompt appears before input

  try:
    result = stdin.readLine()
  except EOFError:
    # Handle Ctrl+D gracefully
    result = "anonymous"
  except IOError as e:
    # Handle system-level I/O failures
    stderr.writeLine "Failed to read input: ", e.msg
    quit(1)

when isMainModule:
  let user = getUsername()
  let p = Person(name: user, age: 25)
  echo "Created person: ", p.name, " (Age: ", p.age, ")"
