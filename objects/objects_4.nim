
type
  Person = object
    name: string
    age: int

proc getUsername(prompt: string = "Enter username: "): string =
  stdout.write prompt
  stdout.flushFile()

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
