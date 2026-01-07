type
  Permission {.pure.} = enum
    Read, Write, Execute

var perms: set[Permission]
perms.incl(Permission.Read)
perms.incl(Permission.Write)

if Permission.Read in perms:
  echo "Readable"
if Permission.Execute notin perms:
  echo "Not executable"
