# Nim distinct benefits
# Prevents argument swapping
# Prevents accidental math
# 1. Define the Distinct Types
type
  Cash = distinct int
  Desc = distinct string

# 2. Enable "Borrowing"
# We need to explicitly tell Nim: "Let Cash do math like an int"
# and "Let both types print to the console like normal variables."
proc `+`(x, y: Cash): Cash {.borrow.}
proc `$`(x: Cash): string {.borrow.}
proc `$`(x: Desc): string {.borrow.}

# 3. Define a Safe Function
# This function REFUSES to run if you pass a normal int or string.
# It demands 'Cash' and 'Desc' specifically.
proc processTransaction(amount: Cash, note: Desc) =
  echo "--- Processing ---"
  echo "Transferring: $" & $amount
  echo "Reason: " & $note
  echo "------------------"

# 4. Main Logic
# We must cast raw data to our distinct types to use them.
var salary: Cash = 5000.Cash
var bonus: Cash = 200.Cash
var memo: Desc = "Monthly Salary".Desc

# We can do math because we borrowed `+`
var totalPay: Cash = salary + bonus

# 5. Calling the function
processTransaction(totalPay, memo)
