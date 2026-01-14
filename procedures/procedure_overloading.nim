# Nim
#
# Procedure overloading

proc getUserCity(firstName: string, lastName: string = "Perez"): string =
  case firstName
  of "Sergio": return "Sergio " & lastName & " lives in Cadiz"
  of "Alicia": return "Alicia " & lastName & " lives in Madrid"
  else: return "Unknown"

proc getUserCity(userID: int): string =
  case userID
  of 1: return "UserID 1 lives in Tokyo"
  of 2: return "UserID 2 lives in Russia"
  else: return "Unknown UserID"

let
  p1 = getUserCity("Sergio")
  p2 = getUserCity(1)
  p3 = getUserCity("Alicia", "Garcia")
  p4 = getUserCity(2)

echo p1
echo p2
echo p3
echo p4

