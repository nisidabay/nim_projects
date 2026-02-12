# startProcess
#
# Best for run a shell command and interact with its output
# Writing to stdin, handling sterr separately, or managing
# background jobs

# Run two process in parallel

import osproc

const opts = {poUsePath, poDaemon, poStdErrToStdOut}
var ps: seq[Process]
var i = 0

for prog in ["ls", "tree"]: # run 2 progs in parallel
  let p = startProcess(prog, "", ["."], nil, opts)
  ps.add(p)

for p in ps:
  for line in p.lines:
    echo line
    i += 1

    if i > 100: break
  p.close()


