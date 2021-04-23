# Package
version       = "0.1.0"
author        = "Reilly Moore"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["bg"]


# Dependencies
requires "nim >= 1.4.4"
requires "fidget#head"
requires "gradient >= 1.0.0"
requires "slappy#head"

# Build Tasks
import os, strutils

let buildflags = " --app:gui --opt:speed --gc:arc "

task buildall, "builds all procedures":
  exec "nimble install -d" # installs dependencies if necessary
  mkDir "bin" # create bin directory
  for f in listFiles("./src/"):
    if f.endswith(".nim"): # loop over every nim src file
      exec "nim c -d:danger" & buildflags & f # build executable w/ flags
      mvFile f[0..^5].toExe, if f[4..^5] == "bg": "bin\\" & "rand".toExe else: "bin\\" & f[4..^5].toExe # move exe to bin, rename if applicable