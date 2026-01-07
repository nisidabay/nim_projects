# Composition example
type
  Engine = object
    horsepower: int
    isRunning: bool

  Car = object
    brand: string
    speed: int
    engine: Engine # ← Composition: Car *has* an Engine

proc startEngine(c: var Car) =
  c.engine.isRunning = true
  echo c.brand, "'s engine started (", c.engine.horsepower, " HP)"

# Constructor-like proc to create a Car.
proc newCar(brand: string, hp: int, speed: int): Car =
  result = Car(
    brand: brand,
    engine: Engine(horsepower: hp, isRunning: false),
    speed: speed
  )

when isMainModule:
  var myCar = newCar("Tesla", 500, 220)
  startEngine(myCar)
  echo myCar.brand, "'s speed (", myCar.speed, " Kh)"
  echo "Engine running? ", myCar.engine.isRunning
