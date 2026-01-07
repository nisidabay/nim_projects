import std/times
import std/monotimes
import std/os # Required for sleep

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

proc newMainMenu(): GameState =
  GameState(state: MainMenu, lastVisited: now())

proc startGame(): GameState =
  GameState(
    state: InGame,
    score: 0,
    lives: 3,
    startTime: getMonoTime()
  )

proc pause(g: GameState): GameState =
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

proc resume(g: GameState): GameState =
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
# --- Corrected Full Simulation ---

echo "=== Game State Machine: Full Lifecycle ==="

# 1. Start at Main Menu
var gs = newMainMenu()
echo "🏠 In Main Menu. Last visited: ", gs.lastVisited.format("HH:mm:ss")

# Simulate waiting for user to click "Start"
echo "   (User is browsing options...)"
sleep(1000)

# 2. Transition: Menu -> Game
# We overwrite 'gs' with the new InGame state
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
import std/monotimes
import std/os # Required for sleep

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

proc newMainMenu(): GameState =
  GameState(state: MainMenu, lastVisited: now())

proc startGame(): GameState =
  GameState(
    state: InGame,
    score: 0,
    lives: 3,
    startTime: getMonoTime()
  )

proc pause(g: GameState): GameState =
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

proc resume(g: GameState): GameState =
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
# --- Corrected Full Simulation ---

echo "=== Game State Machine: Full Lifecycle ==="

# 1. Start at Main Menu
var gs = newMainMenu()
echo "🏠 In Main Menu. Last visited: ", gs.lastVisited.format("HH:mm:ss")

# Simulate waiting for user to click "Start"
echo "   (User is browsing options...)"
sleep(1000)

# 2. Transition: Menu -> Game
# We overwrite 'gs' with the new InGame state
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
