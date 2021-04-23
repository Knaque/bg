# renamed to "rand.exe" when using `nimble buildall`

import fidget, fidget/opengl/base, random

when defined(playsound):
  import slappy

import beams, circles, cubes, glass, notes, space

randomize()

proc loadMain() =
  setTitle("PROCEDURAL BACKGROUND")

  when defined(playsound):
    slappyInit()
    let sound = newSound("parasailing.wav")
    assert sound.duration != 0
    discard sound.play()

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

when defined(playsound):
  slappyClose()