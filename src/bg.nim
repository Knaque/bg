import random, fidget
import fidget/opengl/base

type
  Color = tuple[top, bottom: string]
  Rect = object
    color: Color
    w, h, x, y, v: int

const colors: array[4, Color] = [
  (top: "#F8A1EC", bottom: "#ED91CB"),
  (top: "#9FA2BF", bottom: "#8F8FB5"),
  (top: "#F8E986", bottom: "#EDCF7B"),
  (top: "#A1E68C", bottom: "#A0CF88")
]

var rects: seq[Rect]

proc cleanup() =
  var valid_rects: seq[Rect]
  for rect in rects:
    if rect.y + rect.h >= 0:
      valid_rects.add(rect)
  rects = valid_rects

proc drawMain() =
  # animate rects
  for i, _ in rects:
    rects[i].y -= rects[i].v
  
  # delete offscreen rects
  cleanup()

  # generate new rects
  while rects.len < 25:
    rects.add(
      Rect(
        color: colors[rand(0..3)],
        w: rand(10..100),
        h: rand(10..100),
        x: rand(-9..1279),
        y: rand(720..1000),
        v: rand(1..5)
      )
    )
  
  # render
  for i, rect in rects:
    rectangle "bottom":
      box rect.x, (rect.y.float + (rect.h.float / 2)), rect.w, rect.h.float / 2
      fill rect.color.bottom
    rectangle "top":
      box rect.x, rect.y, rect.w, rect.h
      fill rect.color.top
  rectangle "background":
    box 0, 0, 1280, 720
    fill "#F2F2F2"

proc loadMain() =
  setTitle("pssm background")

startFidget(drawMain, load=loadMain, w=1280, h=720, mainLoopMode=RepaintOnFrame)