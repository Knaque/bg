import random, fidget

type Rect = object
  color: string
  x, y, v: int # x-pos, y-pos, velocity

const colors: array[4, string] = [
  "#FF7500",
  "#D76B00",
  "#DE882D",
  "#DE882D"
]

var rects: seq[Rect] # sequence of rect objects

proc drawMain*() =

  var valid_rects: seq[Rect] # rects that are onscreen

  for i, _ in rects:
    # animate rects
    rects[i].y -= rects[i].v

    # remove offscreen rects
    if rects[i].y + 100 >= 0: # if rect is visible
      valid_rects.add(rects[i])
  rects = valid_rects

  # generate new rects
  while rects.len < 25: # there should always be 25 rect objects
    rects.add(
      Rect(
        color: sample(colors),
        x: rand(-99..1279), # x-pos
        y: rand(720..1000), # y-pos
        v: rand(1..5), # velocity
      )
    )
  
  # draw each rect
  for i, rect in rects:
    group "pumpkin":
      box rect.x, rect.y, 100, 100
      rectangle "nodule1":
        box 0, 10, 40, 90
        fill rect.color
        cornerRadius 20
      rectangle "nodule2":
        box 30, 10, 40, 90
        fill rect.color
        cornerRadius 20
      rectangle "nodule3":
        box 60, 10, 40, 90
        fill rect.color
        cornerRadius 20
      rectangle "stem":
        box 40, 0, 20, 40
        fill "#83602B"
        cornerRadius 5

  # draw background
  rectangle "background":
    box 0, 0, 1280, 720
    fill "#4E4544"