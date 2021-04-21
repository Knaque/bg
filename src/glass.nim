import random, fidget

type Rect = object
  color: string
  w, h, x, y, v: int # width, height, x-pos, y-pos, velocity
  o, r, rv: float # opacity, rotation, rotation velocity

const colors: array[4, string] = [
  "#F8A1EC",
  "#9FA2BF",
  "#F8E986",
  "#A1E68C"
]

var rects: seq[Rect] # sequence of rect objects

proc drawMain*() =

  var valid: seq[Rect] # rects that are onscreen

  for i, rect in rects:
    # animate
    rects[i].y -= rects[i].v
    rects[i].r += rects[i].rv

    # draw
    rectangle "pane":
      box rect.x, rect.y, rect.w, rect.h
      fill rect.color, rect.o
      rotation rect.r

    # cleanup
    if rects[i].y + rects[i].h >= 0: # if rect is visible
      valid.add(rects[i])
  rects = valid

  # generate
  while rects.len < 25: # there should always be 25 rect objects
    rects.add(
      Rect(
        color: sample(colors),
        w: rand(20..100), # width
        h: rand(20..100), # height
        x: rand(-19..1279), # x-pos
        y: rand(720..1000), # y-pos
        v: rand(1..5), # velocity
        o: rand(0.25..1.0), # opacity
        r: rand(0.0..45.0), # initial rotation
        rv: rand(-2.5..2.5), # rotation velocity
      )
    )

  # draw background
  rectangle "background":
    box 0, 0, 1280, 720
    fill "#F2F2F2"

when isMainModule:
  import fidget/opengl/base

  randomize()

  proc loadMain() =
    setTitle("PROCEDURAL BACKGROUND")

  startFidget(
    draw=drawMain,
    load=loadMain,
    w=1280,
    h=720,
    mainLoopMode=RepaintOnFrame
  )