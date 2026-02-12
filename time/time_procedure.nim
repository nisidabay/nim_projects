# Nim - Simple way to time a proc

import std/times

proc timeProcedure() =
    let start = now()
# tested procedure goes here
    for i in 0..1_000_000:
        discard i * i

    let elapsed = now() - start
    echo "Time taken: ", elapsed.inSeconds(), " seconds"
    echo "Time taken: ", elapsed.inMilliseconds(), " milliseconds"
    echo "Time taken: ", elapsed.inMicroseconds(), " microseconds"
    echo "Time taken: ", elapsed.inNanoseconds(), " nanoseconds"

timeProcedure()


