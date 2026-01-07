import std/times

# 1. Adding and Subtracting Time ("Time Travel")
# Use this when you need to calculate deadlines, expiration dates, or look into
# the past.

let rightNow = now()
echo "Current Time: ", rightNow.format("yyyy-MM-dd HH:mm")

# --- ADDING TIME ---
# Use 'initDuration' to create a span of time (hours, days, weeks).
# Then add it to a Time object using standard math operators (+).
let threeDays = initDuration(days = 3)
let fiveHours = initDuration(hours = 5)

let deadline = rightNow + threeDays + fiveHours
echo "Deadline (3 days, 5 hours later): ", deadline.format("yyyy-MM-dd HH:mm")

# --- SUBTRACTING TIME ---
# Use this to calculate past dates (e.g., "7 days ago").
let oneWeekAgo = rightNow - initDuration(weeks = 1)
echo "One week ago was: ", oneWeekAgo.format("yyyy-MM-dd")

# 2. Calculating the Gap Between Times (Subtraction)
#Use this when you need to know "how long" something took or how many days are
#left until an event.

# Let's say we have two specific dates
let releaseDate = now()
let nextYear = releaseDate + initDuration(weeks = 52)

# --- CALCULATING INTERVALS ---
# Subtracting two times (Time - Time) creates a 'Duration' object.
let gap = nextYear - releaseDate

# You can convert that gap into different units (days, hours, seconds).
echo "Days until next year: ", gap.inDays
echo "Hours until next year: ", gap.inHours
echo "Seconds until next year: ", gap.inSeconds

# 3. Parsing (Text to Time) and Formatting (Time to Text)
# Use this when reading dates from a file/user input (`parse`) or displaying
# them nicely (`format`).

# You must tell Nim the pattern the string uses (e.g., "yyyy-MM-dd").
let dateString = "2025-12-25"
let christmas = parse(dateString, "yyyy-MM-dd")

echo "Timezone used: ", christmas.timezone.name
echo "Parsed Date Object: ", christmas
echo "Is it DST?: ", christmas.isDst # Checks Daylight Savings

# --- FORMATTING (Time -> Text) ---
# Use 'format' to make the time readable for humans.
# "ddd" = Short day name (Mon), "MMMM" = Full month name (December)
echo "Pretty Print: ", christmas.format("ddd, MMMM d, yyyy")

# 4. Accessing Specific Calendar Parts
# Use this when you need to check specific conditions, like "Is today Friday?"
# or "Is the year 2025?".

let today = now()

# Access specific parts using .year, .month, .weekday, .yearday
echo "Current Year: ", today.year
echo "Current Month: ", today.month

# Example: Logic based on the day of the week
if today.weekday == dSat or today.weekday == dSun:
    echo "It is the weekend!"
else:
    echo "It is a work day."

# Example: Day of the year (1-366)
echo "Day number of the year: ", today.yearday

# Summary of `initDuration`
# This function is critical for time math. You can combine multiple units at
# once:

# Creates a duration of 1 day, 2 hours, and 30 minutes
let span = initDuration(days = 1, hours = 2, minutes = 30)
echo "Span: ", span

