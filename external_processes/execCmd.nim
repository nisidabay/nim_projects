# execCmd
# Best for: One-shot scripts where the user must see output immediately

import std/[osproc, os]

# Define the target directory as a tilde-expanded path
let target = "~/nim_projects"
let data = expandTilde(target)

# Execute the tar command to create a compressed archive of the target directory
let code = execCmd("tar -czf backup.tar.gz " & quoteShell(data))

# Check if the execution was successful by verifying the exit code
if code != 0:
  quit "Backup failed with exit code: " & $code
