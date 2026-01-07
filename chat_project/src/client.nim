import os, threadpool

echo("Chat application started")
if paramCount() == 0:
  quit("Please specify the server address, e.g. ./client localhost")

let serverAddr = paramStr(1)
echo("Connected to ", serverAddr)

while true:
  let message = spawn stdin.readline()
  echo("Sending \"", ^message, "\"")
