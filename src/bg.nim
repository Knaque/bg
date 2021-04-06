import fidget, fidget/opengl/base, random

import procedures/[beams, circles, cubes, glass]

randomize()

proc loadMain() =
  setTitle("PROCEDURAL BACKGROUND")

startFidget(
  # use random procedure on start
  sample([beams.drawMain, circles.drawMain, cubes.drawMain, glass.drawMain]),
  load=loadMain,
  w=1280,
  h=720,
  mainLoopMode=RepaintOnFrame
)