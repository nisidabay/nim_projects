import std/times, std/os

# ==========================================
# 1. HUMAN TIME VS MACHINE TIME
# ==========================================

# 'now()' returns the time as humans see it (Context-aware: Timezone, DST).
# Use this for user interfaces, calendars, and receipts.
let humanTime = now()
echo "--- Basic Time ---"
echo "Local Wall Clock: ", humanTime.format("yyyy-MM-dd HH:mm:ss zzz")

# 'getTime()' returns the absolute machine moment (a counter).
# Use this for databases or internal logic. It has no timezone.
let machineTime = getTime()
echo "Machine Absolute: ", machineTime

# ==========================================
# 2. CONVERTING VIEWS (UTC vs LOCAL)
# ==========================================

echo "\n--- Conversions ---"
# Convert Machine Time to UTC (Standard Universal Time)
# ALWAYS use this when saving to a server/database.
let utcView = machineTime.utc()
echo "UTC View:   ", utcView

# Convert Machine Time to Local (Computer's Timezone)
# Use this when showing data back to a user.
let localView = machineTime.local()
echo "Local View: ", localView

# Convert back to raw machine time
let originalTime = localView.toTime()
echo "Back to Machine: ", originalTime

# ==========================================
# 3. STOPWATCH (DURATION)
# ==========================================

echo "\n--- Stopwatch ---"
let start = getTime()
echo "Starting timer..."
sleep(500) # Sleep for 500 milliseconds (0.5 seconds)
let elapsed = (getTime() - start).inMilliseconds
echo "Task took: ", elapsed, " ms"

# ==========================================
# 4. TIME ARITHMETIC (ADDING & SUBTRACTING)
# ==========================================

echo "\n--- Time Math ---"
let rightNow = now()

# Create 'Duration' objects to represent spans of time
let threeDays = initDuration(days = 3)
let fiveHours = initDuration(hours = 5)
let oneWeek = initDuration(weeks = 1)

# FUTURE: Add time using +
let deadline = rightNow + threeDays + fiveHours
echo "Deadline (3d 5h from now): ", deadline.format("yyyy-MM-dd HH:mm")

# PAST: Subtract time using -
let lastWeek = rightNow - oneWeek
echo "Last week was: ", lastWeek.format("yyyy-MM-dd")

# CALCULATE GAP: Subtracting two dates gives a 'Duration'
let gap = deadline - rightNow
echo "Hours until deadline: ", gap.inHours

# ==========================================
# 5. PARSING (TEXT -> TIME) & DST
# ==========================================

echo "\n--- Parsing & DST ---"
let dateString = "2025-12-25"
# parse() assumes the Local Timezone of the computer running the code
let christmas = parse(dateString, "yyyy-MM-dd")

echo "Parsed Date: ", christmas
echo "Is it DST locally?: ", christmas.isDst

# To check DST in UTC (which is always false), convert the view:
echo "Is it DST in UTC?:  ", christmas.utc.isDst

# ==========================================
# 6. FORMATTING (TIME -> TEXT)
# ==========================================

echo "\n--- Formatting Reference ---"
let t = now()

# Standard Date & Time
echo "ISO Date:      ", t.format("yyyy-MM-dd")
echo "US Date:       ", t.format("MM/dd/yyyy")

# 24-Hour vs 12-Hour
echo "24-Hour (HH):  ", t.format("HH:mm") # e.g., 14:30
echo "12-Hour (hh):  ", t.format("hh:mm tt") # e.g., 02:30 PM

# Precision
echo "Milliseconds:  ", t.format("HH:mm:ss'.'fff")

# QUOTING TEXT
# If you need specific text inside the format string, wrap it in single quotes.
# This prevents Nim from confusing letters (like 'd' or 's') with time codes.

# Example: Underscores
echo "Underscore:    ", t.format("yyyy'_'MM'_'dd")

# Example: Words inside the date string
echo "With Text:     ", t.format("'backup_'yyyy'_'MM'_'dd")

# Example: ISO 8601 (The 'T' and 'Z' must be quoted)
echo "ISO Standard:  ", t.utc().format("yyyy-MM-dd'T'HH:mm:ss'Z'")

# Full Human Readable
echo "Full Date:     ", t.format("dddd, MMMM d, yyyy")
