# Nim
#
# Times examples

import std/[times, monotimes, os]

# Define the state types
type
  StateKind = enum
    MainMenu, InGame, Paused

  GameState = object
    case state: StateKind
    of MainMenu:
      lastVisited: DateTime
    of InGame:
      score: int
      lives: int
      startTime: MonoTime
    of Paused:
      pauseTime: MonoTime
      elapsedBeforePause: Duration
      # The fixed fields to preserve state
      savedScore: int
      savedLives: int

# Procedure to initialize main menu state
proc newMainMenu(): GameState =
  # Initialize a main menu state with current time as last visited
  GameState(state: MainMenu, lastVisited: now())

# Procedure to start a new game
proc startGame(): GameState =
  # Initialize an in-game state with default values
  GameState(
    state: InGame,
    score: 0,
    lives: 3,
    startTime: getMonoTime()
  )

# Procedure to pause the game and save relevant state
proc pause(g: GameState): GameState =
  # Pause the game and save relevant state information
  case g.state
  of InGame:
    let elapsed = getMonoTime() - g.startTime
    echo "  > [System] Pausing game..."
    result = GameState(
      state: Paused,
      pauseTime: getMonoTime(),
      elapsedBeforePause: elapsed,
      savedScore: g.score,
      savedLives: g.lives
    )
  else:
    raise newException(Defect, "Can only pause InGame.")

# Procedure to resume the game from paused state
proc resume(g: GameState): GameState =
  # Resume the game from paused state with proper state restoration
  case g.state
  of Paused:
    # Set the clock back so it looks like no time passed
    let newStartTime = getMonoTime() - g.elapsedBeforePause
    echo "  > [System] Resuming game..."
    result = GameState(
      state: InGame,
      score: g.savedScore, # Restore score
      lives: g.savedLives, # Restore lives
      startTime: newStartTime
    )
  else:
    raise newException(Defect, "Can only resume Paused game.")

# Procedure to demonstrate the full game lifecycle
proc demonstrateGameLifecycle(): void =
  # Show the complete game state machine lifecycle
  echo "=== Game State Machine: Full Lifecycle ==="

  # 1. Start at Main Menu
  var gs = newMainMenu()
  echo "🏠 In Main Menu. Last visited: ", gs.lastVisited.format("HH:mm:ss")

  # Simulate waiting for user to click "Start"
  echo "   (User is browsing options...)"
  sleep(1000)

  # 2. Transition: Menu -> Game
  # We overwrite gs with the new InGame state
  gs = startGame()
  echo "🚀 User clicked Start! Game initialized."

  # 3. Play for a bit
  gs.score = 100
  echo "🎮 Playing... (Score: ", gs.score, ")"
  sleep(2000)

  # 4. Pause
  gs = pause(gs)
  echo "⏸️  Paused."

  # 5. Resume
  sleep(1000) # Wait a bit
  gs = resume(gs)
  echo "▶️  Resumed. Score is still: ", gs.score

# Procedure to demonstrate time handling
proc demonstrateTimeHandling(): void =
  # Show time handling functionality with Unix timestamps
  let unixTime = getTime().toUnix
  echo "Unix timestamp: ", unixTime

  let t = fromUnix(unixTime).utc
  echo "UTC time from timestamp: ", t

  let now1 = getTime().local
  let now2 = now()

  assert now1 != now2
  echo "Verification: getTime().local != now() - confirmed"

# Add entry points to call each procedure
when isMainModule:
  # demonstrateGameLifecycle()
  demonstrateTimeHandling()
