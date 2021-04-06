import random, fidget
import fidget/opengl/base

type
  Color = tuple[top, bottom: string]
  Rect = object
    color: Color
    w, h, x, y, v, s: int
    t: float

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
        w: rand(20..100),
        h: rand(20..100),
        x: rand(-19..1269),
        y: rand(720..1000),
        v: rand(1..5),
        s: rand(10..20),
        t: rand(1.1..3.0)
      )
    )
  
  # render
  for i, rect in rects:
    rectangle "top":
      box rect.x, rect.y, rect.w, rect.h.float / rect.t
      fill rect.color.top
    rectangle "bottom":
      box rect.x, rect.y, rect.w, rect.h
      fill rect.color.bottom
    rectangle "shadow":
      box rect.x, rect.y + rect.h, rect.w, rect.s
      fill "#000000", 0.05
  rectangle "background":
    box 0, 0, 1280, 720
    fill "#F2F2F2"

proc loadMain() =
  setTitle("pssm background")

when defined(release):
  echo "release :)"

startFidget(drawMain, load=loadMain, w=1280, h=720, mainLoopMode=RepaintOnFrame)