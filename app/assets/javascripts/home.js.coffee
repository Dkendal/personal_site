a = 0
redraw = {}
pi = Math.PI

introAnim = (name) ->
  $("[data-anim='intro-#{name}']")

animate = (animName) -> ($elm) ->
  $elm.addClass("animated #{animName}")

fadeInUp = animate 'fadeInUp'
fadeIn = animate 'fadeIn'

erase = ( path ) -> () ->
  window.clearTimeout redraw
  path.setAttribute "d", ''
  a = 0

drawArc = (time, radius) ->
  fps = 1e3 / 30
  step = fps * 360/time
  ( path ) ->
    boundDrawArc = () ->
      a += step
      lastSegment = a >= 360

      if lastSegment
        a = 359.9 # setting this to 360 will make no circle.

      r = (a * pi / 180)
      x = Math.sin(r) * radius
      y = Math.cos(r) * -radius

      mid = if (a > 180) then 1 else 0
      anim = "M 0 -#{radius} A #{radius} #{radius} 0 #{mid} 1 #{x} #{y}"

      if lastSegment
        anim += " z"

      path.setAttribute "d", anim

      unless lastSegment
        redraw = setTimeout boundDrawArc, fps

main = ->
  $name = introAnim "name"
  $bar = introAnim "bar"
  $sub = introAnim "sub"

  fadeIn $name

  setTimeout -> fadeInUp $bar, 300
  setTimeout -> fadeInUp $sub, 400

  $('[data-fancy-hover]').each ->
    path = $(@).find('path')[0]
    $(@).hover drawArc(400, 60)(path), erase(path)

$ -> main()
