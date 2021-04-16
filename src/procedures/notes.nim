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
        v: rand(1..5), # velocity
        duration: sample([Half, Quarter, Eighth]), # duration
        flipped: sample([true, false])
      )
    )
  
  # draw each rect
  for i, rect in rects:
    group "bounds":
      case rect.duration
      of Half:
        if rect.flipped:
          box rect.x, rect.y, 50, 125
          rectangle "head":
            box 0, 0, 50, 50
            cornerRadius 50
            fill "#000000", 0
            stroke rect.color
            strokeWeight 10
          rectangle "beam":
            box 0, 25, 10, 100
            fill rect.color
            cornerRadius 5
          rectangle "cover":
            box 0, 25, 10, 10
            fill rect.color
        else:
          box rect.x, rect.y, 50, 125
          rectangle "head":
            box 0, 75, 50, 50
            cornerRadius 50
            fill "#000000", 0
            stroke rect.color
            strokeWeight 10
          rectangle "beam":
            box 40, 0, 10, 100
            fill rect.color
            cornerRadius 5
          rectangle "cover":
            box 40, 90, 10, 10
            fill rect.color
      of Quarter:
        if rect.flipped:
          box rect.x, rect.y, 50, 125
          rectangle "head":
            box 0, 0, 50, 50
            cornerRadius 50
            fill rect.color
          rectangle "beam":
            box 0, 25, 10, 100
            fill rect.color
            cornerRadius 5
          rectangle "cover":
            box 0, 25, 10, 10
            fill rect.color
        else:
          box rect.x, rect.y, 50, 125
          rectangle "head":
            box 0, 75, 50, 50
            cornerRadius 50
            fill rect.color
          rectangle "beam":
            box 40, 0, 10, 100
            fill rect.color
            cornerRadius 5
          rectangle "cover":
            box 40, 90, 10, 10
            fill rect.color
      of Eighth:
        box rect.x, rect.y, 150, 125
        if rect.flipped:
          rectangle "head1":
            box 0, 0, 50, 50
            cornerRadius 50
            fill rect.color
          rectangle "head2":
            box 100, 0, 50, 50
            cornerRadius 50
            fill rect.color
          rectangle "beam1":
            box 0, 25, 10, 100
            fill rect.color
            cornerRadius 5
          rectangle "cover1":
            box 0, 25, 10, 10
            fill rect.color
          rectangle "beam2":
            box 100, 25, 10, 100
            fill rect.color
            cornerRadius 5
          rectangle "cover2":
            box 100, 25, 10, 10
            fill rect.color
          rectangle "connector beam":
            box 5, 115, 100, 10
            fill rect.color
        else:
          rectangle "head1":
            box 0, 75, 50, 50
            cornerRadius 50
            fill rect.color
          rectangle "head2":
            box 100, 75, 50, 50
            cornerRadius 50
            fill rect.color
          rectangle "beam1":
            box 40, 0, 10, 100
            fill rect.color
            cornerRadius 5
          rectangle "cover1":
            box 40, 90, 10, 10
            fill rect.color
          rectangle "beam2":
            box 140, 0, 10, 100
            fill rect.color
            cornerRadius 5
          rectangle "cover2":
            box 140, 90, 10, 10
            fill rect.color
          rectangle "connector beam":
            box 45, 0, 100, 10
            fill rect.color

  # draw background
  rectangle "background":
    box 0, 0, 1280, 720
    fill "#F2F2F2"