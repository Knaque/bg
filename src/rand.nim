import fidget, fidget/opengl/base, random

import beams, circles, cubes, glass, notes, space

randomize()

proc loadMain() =
  setTitle("PROCEDURAL BACKGROUND")

startFidget(
  draw=sample(
    [
      beams.drawMain,
      circles.drawMain,
      cubes.drawMain,
      glass.drawMain,
      notes.drawMain,
      space.drawMain
    ]
  ),
  load=loadMain,
  w=1280,
  h=720,
  mainLoopMode=RepaintOnFrame
)