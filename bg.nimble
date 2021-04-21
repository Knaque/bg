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


# Build Tasks
import os, strutils

let buildflags = " --app:gui --opt:speed --gc:arc "

task buildall, "builds all procedures":
  mkDir "bin"
  for f in listFiles("./src/"):
    if f.endswith(".nim"):
      exec "nim c -d:danger" & buildflags & f
      mvFile f[0..^5].toExe, "bin\\" & f[4..^5].toExe