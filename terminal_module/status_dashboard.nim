import std/[terminal, strformat, os, times, random, strutils]

type Service = object
  name: string
  status: string # "running", "stopped", "error"
  uptime: Duration

proc renderDashboard(services: seq[Service]) =
  # Clear and position
  eraseScreen()
  setCursorPos(0, 0)

  # Header
  stdout.styledWrite(styleBright, fgBlue, "=== SERVICE DASHBOARD ===\n", resetStyle)
  echo "Updated: ", now().format("HH:mm:ss")
  echo ""

  # Service rows
  for svc in services:
    let statusColor = case svc.status
      of "running": fgGreen
      of "stopped": fgYellow
      of "error": fgRed
      else: fgWhite

    stdout.styledWrite(
      fgCyan, alignLeft(svc.name, 20),
      resetStyle, " [",
      statusColor, alignLeft(svc.status, 8),
      resetStyle, "] ",
      fgWhite, fmt"uptime: {svc.uptime.inSeconds} seconds", "\n"
    )

  # Footer
  echo "\n" & "-".repeat(40)
  echo "Press 'q' to quit, 'r' to refresh"

proc runApp() =
  var services = @[
    Service(name: "web-server", status: "running", uptime: initDuration(
        seconds = 3600)),
    Service(name: "database", status: "running", uptime: initDuration(
        seconds = 7200)),
    Service(name: "cache", status: "stopped", uptime: initDuration(seconds = 0))
  ]

  hideCursor()
  defer: showCursor()

  while true:
    renderDashboard(services)

    # Simulate status changes
    services[2].uptime = initDuration(seconds = services[2].uptime.inSeconds + 5)

    # Check for quit
    sleep(2000) # Refresh every 2 seconds
    
    # Non-blocking check for input
    try:
      let c = getch()
      if c == 'q': break
      if c == 'r': continue # Force refresh
    except:
      discard # No input available
    
    # Rotate status for demo
    if rand(1.0) > 0.7:
      services[1].status = if services[1].status ==
          "running": "error" else: "running"

when isMainModule:
  runApp()
