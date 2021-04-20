import random, fidget, gradient, sequtils

type
  Rect = object of RootObj
    d, x: int # diameter, x-pos
    y, v, o: float # y-pos, velocity, opacity
  Star = object of Rect
  Nebula = object of Rect
    color: string

let colors = polylinearGradient(
  [
    "#00FFFF".parseHtmlHex,
    "#0000FF".parseHtmlHex,
    "#FF00FF".parseHtmlHex
  ],
  10
).map(
  proc(x: Color): string = toHtmlHex(x)
)

var stars: seq[Star] # sequence of star objects
var nebulae: seq[Nebula]

proc drawMain*() =

  block CleanupStars:
    var valid_stars: seq[Star] # rects that are onscreen

    for i, _ in stars:
      # animate rects
      stars[i].y -= stars[i].v

      # remove offscreen rects
      if stars[i].y + stars[i].d.float >= 0: # if star is visible
        valid_stars.add(stars[i])
    stars = valid_stars

  block CleanupNebulae:
    var valid_nebulae: seq[Nebula]

    for i, _ in nebulae:
      # animate rects
      nebulae[i].y -= nebulae[i].v

      # remove offscreen rects
      if nebulae[i].y + nebulae[i].d.float >= 0: # if star is visible
        valid_nebulae.add(nebulae[i])
    nebulae = valid_nebulae

  # generate new stars
  while stars.len < 200: # there should always be 200 star objects
    stars.add(
      Star(
        d: rand(1..5), # diameter
        x: rand(-4..1279), # x-pos
        y: rand(720.0..1000.0), # y-pos
        v: rand(0.5..5.0), # velocity
        o: rand(0.25..1.0) # opacity
      )
    )

  while nebulae.len < 50:
    nebulae.add(
      Nebula(
        d: rand(10..500), # diameter
        x: rand(-499..1279), # x-pos
        y: rand(720.0..1000.0), # y-pos
        v: rand(0.5..5.0), # velocity
        o: rand(0.01..0.1), # opacity
        color: sample(colors) # color
      )
    )
  
  # draw each star
  for i, star in stars:
    rectangle "star":
      box star.x, star.y, star.d, star.d
      fill "#FFFFFF", star.o
      cornerRadius star.d.float / 2

  # draw each nebula
  for i, nebula in nebulae:
    rectangle "nebula":
      box nebula.x, nebula.y, nebula.d, nebula.d
      fill nebula.color, nebula.o
      cornerRadius nebula.d.float / 2

  # draw background
  rectangle "background":
    box 0, 0, 1280, 720
    fill "#000000"