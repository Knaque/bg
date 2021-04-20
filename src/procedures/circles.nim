import random, fidget

type Rect = object
  color: string
  d, x, y, v: int # diameter, x-pos, y-pos, velocity
  o: float # opacity

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
    rectangle "circle":
      box rect.x, rect.y, rect.d, rect.d
      fill rect.color, rect.o
      cornerRadius rect.d.float / 2

    # cleanup
    if rects[i].y + rects[i].d >= 0: # if rect is visible
      valid.add(rects[i])
  rects = valid

  # generate
  while rects.len < 25: # there should always be 25 rect objects
    rects.add(
      Rect(
        color: sample(colors),
        d: rand(20..100), # diameter
        x: rand(-19..1279), # x-pos
        y: rand(720..1000), # y-pos
        v: rand(1..5), # velocity
        o: rand(0.25..1.0), # opacity
      )
    )

  # draw background
  rectangle "background":
    box 0, 0, 1280, 720
    fill "#F2F2F2"