import random, fidget

type
  Rect = object
    color: string
    w, h, x, y, v: int # width, height, x-pos, y-pos, velocity
    o: float # opacity

const colors: array[4, string] = [
  "#F8A1EC",
  "#9FA2BF",
  "#F8E986",
  "#A1E68C"
]

var rects: seq[Rect] # sequence of rect objects

proc drawMain*() =

  var valid_rects: seq[Rect] # rects that are onscreen

  for i, _ in rects:
    # animate rects
    rects[i].y -= rects[i].v

    # remove offscreen rects
    if rects[i].y + rects[i].h >= 0: # if rect is visible
      valid_rects.add(rects[i])
  rects = valid_rects

  # generate new rects
  while rects.len < 25: # there should always be 25 rect objects
    rects.add(
      Rect(
        color: colors[rand(0..3)],
        w: rand(5..20), # width
        h: rand(20..200), # height
        x: rand(-4..1279), # x-pos
        y: rand(720..1000), # y-pos
        v: rand(1..5), # velocity
        o: rand(0.25..1.0) # opacity
      )
    )
  
  # draw each rect
  for i, rect in rects:
    rectangle "beam":
      box rect.x, rect.y, rect.w, rect.h
      fill rect.color, rect.o

  # draw background
  rectangle "background":
    box 0, 0, 1280, 720
    fill "#F2F2F2"