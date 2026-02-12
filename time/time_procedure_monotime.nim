import std/monotimes

proc timeMonotonicProcedure() =
  let start = getMonoTime()
  # Your procedure code here
  # For demonstration, let's simulate some work
  for i in 0..1_000_000:
    discard i * i
  let elapsed = getMonoTime() - start
  echo "Monotonic Time taken: ", elapsed

timeMonotonicProcedure()

