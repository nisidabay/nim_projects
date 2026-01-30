import std/[options, strutils]

type
  User = object
    id: int
    username: string
    isActive: bool

# 1. A fake database function
func findUserById(id: int): Option[User] =
  if id == 1:
    return some(User(id: 1, username: "nim_fan", isActive: true))
  elif id == 2:
    return some(User(id: 2, username: "lazy_coder", isActive: false))
  else:
    return none(User)

# 2. Define small helper functions (To avoid 'sugar' arrows)
func checkActive(u: User): bool =
  return u.isActive

func getName(u: User): string =
  return u.username

func makeUpper(s: string): string =
  return s.toUpperAscii()

# --- MAIN LOGIC ---

let searchId = 1 # Try changing this to 2 (inactive) or 99 (missing)

let finalResult = findUserById(searchId)
  .filter(checkActive) # Step 1: Keep only if active
  .map(getName)        # Step 2: Extract just the username
  .map(makeUpper)      # Step 3: Convert to UPPERCASE

if finalResult.isSome:
  echo "Success! User is: ", finalResult.get()
else:
  echo "Result is empty (User not found OR User was inactive)"

