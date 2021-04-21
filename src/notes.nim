import random, fidget

type
  Duration = enum
    Half, Quarter, Eighth
  Rect = object
    color: string
    x, y, v: int # width, height, x-pos, y-pos, velocity
    duration: Duration # duration
    flipped: bool # is flipped?

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

    # draw
    group "v2":
      box rect.x, rect.y, 150, 125
      rectangle "head":
        if rect.flipped: box 0, 0, 50, 50
        else: box 0, 75, 50, 50
        if rect.duration == Half:
          fill "#F2F2F2", 0
          stroke rect.color
          strokeWeight 10
        else: fill rect.color
        cornerRadius 50
      rectangle "beam":
        if rect.flipped: box 0, 25, 10, 100
        else: box 40, 0, 10, 100
        fill rect.color
        cornerRadius 5
      rectangle "cover":
        if rect.flipped: box 0, 25, 10, 10
        else: box 40, 90, 10, 10
        fill rect.color
      if rect.duration == Eighth:
          rectangle "head2":
            if rect.flipped: box 100, 0, 50, 50
            else: box 100, 75, 50, 50
            cornerRadius 50
            fill rect.color
          rectangle "beam2":
            if rect.flipped: box 100, 25, 10, 100
            else: box 140, 0, 10, 100
            fill rect.color
            cornerRadius 5
          rectangle "cover2":
            if rect.flipped: box 100, 25, 10, 10
            else: box 140, 90, 10, 10
            fill rect.color
          rectangle "connector":
            if rect.flipped: box 5, 115, 100, 10
            else: box 45, 0, 100, 10
            fill rect.color

    # cleanup
    if rects[i].y + 200 >= 0: # if rect is visible
      valid.add(rects[i])
  rects = valid

  # generate
  while rects.len < 25: # there should always be 25 rect objects
    rects.add(
      Rect(
        color: sample(colors),
        x: rand(-149..1279), # x-pos
        y: rand(720..1000), # y-pos
        v: rand(1..5), # velocity
        duration: sample([Half, Quarter, Eighth]), # duration
        flipped: sample([true, false])
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