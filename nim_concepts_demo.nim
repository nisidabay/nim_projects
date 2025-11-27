# nim_concepts_demo.nim
# Demonstrates key Nim concepts with explanations, pitfalls, and best practices.
# Compatible with Nim 2.2.4

# =============================================================================
# 1. TYPE ALIASES vs DISTINCT TYPES
# =============================================================================

type
  # 🔹 Type Alias: just a synonym — no safety
  UserId = int
  Name = string

  # 🔹 Distinct Type: creates a NEW type — prevents accidental mixing
  Cash = distinct int
  Email = distinct string

var
  user_id: UserId = 42
  name: Name = "Alice"
  wallet: Cash = 100.Cash # Must explicitly convert!
  contact: Email = "a@example.com".Email

# ✅ Why use aliases?
# → Improve readability without runtime cost.
# → But: NO type safety! You can assign any `int` to `UserId`.
user_id = 999 # Totally allowed — even if it's nonsense.

# ✅ Why use `distinct`?
# → Prevent bugs like assigning a password hash to an email field.
# ⚠️ Pitfall: You CANNOT mix `Cash` and `int` accidentally.
# wallet = 50   # ❌ COMPILE ERROR! Uncomment to see.
# wallet = 50.Cash  # ✅ Correct way.

# To use a `distinct` value, convert back:
echo "Wallet balance: ", wallet.int, " units"

# ⚠️ Caveat: `distinct` types lose all operations of base type.
# You must define your own or use converters (advanced).
# Example: `wallet + 10.Cash` won’t work unless you define `+`.

# =============================================================================
# 2. TUPLES vs OBJECTS vs REF OBJECTS
# =============================================================================

type
  # 🔹 Tuple: lightweight, ordered, indexable, no methods
  Point2D = tuple[x: float, y: float]

  # 🔹 Object: stack-allocated, copied on assignment
  Person = object
    name: string = "Anonymous"
    age: int = 0
    active: bool = true

  # 🔹 Ref Object: heap-allocated, reference semantics (like classes)
  Node = ref object
    value: int
    next: Node # cyclic reference allowed!

var
  origin: Point2D = (x: 0.0, y: 0.0)
  friend: Person = Person(name: "Bob", age: 30)

# ✅ Tuples are great for temporary, small structured data.
echo "Origin: (", origin.x, ", ", origin[1], ")"

# ⚠️ Pitfall: Tuples with same field types are compatible even if names differ!
let fakePoint = (a: 1.0, b: 2.0) # Different names
                                 # assert origin == fakePoint  # ✅ This would COMPILE and pass! (Dangerous?)

# ✅ Objects enforce field names and are safer for modeling domain data.
echo "Friend: ", friend.name, ", age ", friend.age

# ⚠️ Pitfall: Objects CANNOT be accessed by index.
# echo friend[0]  # ❌ Compile error! No positional access.

# =============================================================================
# 2B. REF OBJECTS: WHEN AND WHY TO USE THEM
# =============================================================================

# 🔹 Use `ref object` when:
#   - You need shared or mutable references (e.g., trees, graphs, linked lists).
#   - The data is large and copying is expensive.
#   - You need cyclic structures (impossible with plain `object`).

# ✅ Example: building a simple linked list
var head: Node
head = Node(value: 1)
head.next = Node(value: 2)
head.next.next = Node(value: 3)

# Traverse the list
var current = head
while current != nil:
  echo "Node value: ", current.value
  current = current.next

# ⚠️ Caveat: Nim uses a **deferred reference-counting GC**.
#   - It does **NOT** collect cyclic references by default!
#   - If you create a cycle (e.g., `node.next = node`), it leaks memory.
#
# Example of a dangerous cycle:
let cyclic: Node = Node(value: 42)
cyclic.next = cyclic # 🚫 Memory leak! GC won’t free this.
# → Avoid cycles, or break them manually before they go out of scope.

# ✅ Best practice: prefer acyclic structures, or use weak refs (advanced).
# For most apps (e.g., trees, lists), ref objects are safe and efficient.

# =============================================================================
# 3. COMPILE-TIME EVALUATION: `const` and `when`
# =============================================================================

const
  # 🔹 `const`: evaluated at compile time — must be computable without running
  AppName = "NimConceptsDemo"
  MaxRetries = 5
  Pi = 3.1415926535

# ⚠️ Pitfall: You CANNOT use runtime values in `const`.
# const userInput = readLine(stdin)  # ❌ Compile error!

when defined(debug): # or: when true / when false
  # 🔹 `when`: compile-time conditional — unused branches are ELIMINATED
  echo "🔍 Debug mode: App = ", AppName
  const BuildMode = "debug"
else:
  echo "🚀 Release mode"
  const BuildMode = "release"

# ✅ Why use `when`?
# → Zero-cost feature flags, OS-specific code, debug logging removal.
# → Unlike `if`, the unused branch doesn’t even exist in the binary!

# ⚠️ Common mistake: confusing `if` and `when`
var runtimeFlag = true
  # when runtimeFlag:  # ❌ ERROR! `runtimeFlag` is not known at compile time.
  #   echo "This won't work!"

  # ✅ Correct: use `if` for runtime conditions
if runtimeFlag:
  echo "Runtime flag is on"

# =============================================================================
# BONUS: ENUMS + SUBRANGES (from Learn X in Y Minutes)
# =============================================================================

type
  LogLevel = enum
    Info, Warning, Error

  DiceRoll = range[1..6] # Only 1–6 allowed

var
  level: LogLevel = Warning
  roll: DiceRoll = 4

# ✅ Enums are ordinal — can be compared, converted to int
echo "Log level index: ", ord(level) # → 1

# ⚠️ Pitfall: Subrange assignment out of bounds = compile error
# roll = 10  # ❌ Won't compile!

# =============================================================================
# FINAL SUMMARY
# =============================================================================

echo "\n✅ Summary:"
echo "- Use `type X = Y` for clarity, not safety."
echo "- Use `distinct` when you need to prevent accidental mixing."
echo "- Use `tuple` for small, temporary data; `object` for domain models."
echo "- Use `ref object` for shared, large, or recursive data structures."
echo "- Beware of reference cycles with `ref object` — they leak memory!"
echo "- Use `const`/`when` for zero-cost, compile-time logic."
echo "- Avoid runtime values in compile-time contexts!"

echo "\n🎉 All concepts demonstrated safely!"
