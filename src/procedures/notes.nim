import random, fidget

type
  Rect = object
    color: string
    x, y, v: int # width, height, x-pos, y-pos, velocity

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
    if rects[i].y + 200 >= 0: # if rect is visible
      valid_rects.add(rects[i])
  rects = valid_rects

  # generate new rects
  while rects.len < 25: # there should always be 25 rect objects
    rects.add(
      Rect(
        color: sample(colors),
        x: rand(-49..1279), # x-pos
        y: rand(720..1000), # y-pos
        v: rand(1..5) # velocity
      )
    )
  
  # draw each rect
  for i, rect in rects:
    group "note":
      box rect.x, rect.y, 50, 100
      rectangle "head":
        box 0, 50, 50, 50
        cornerRadius 50
        fill rect.color
      rectangle "beam":
        box 40, 0, 10, 75
        fill rect.color

  # draw background
  rectangle "background":
    box 0, 0, 1280, 720
    fill "#F2F2F2"