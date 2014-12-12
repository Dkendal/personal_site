scrollTo = (str) ->
  $('html, body').animate({scrollTop: $(str).offset().top}, 500, "linear")

introAnim = (name) -> $("[data-anim='intro-#{name}']")

$.fn.chain = (callback) ->
  @.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', callback)

$ ->
  $name = introAnim "name"
  $bar = introAnim "bar"
  $sub = introAnim "sub"

  $name.addClass("animated fadeIn")

  window.setTimeout ( -> $bar.addClass("animated fadeInUp") ), 300
  window.setTimeout ( -> $sub.addClass("animated fadeInUp") ), 400


  time = 300
  a = 0
  pi = Math.PI
  fps = 1e3 / 30
  radius = 115
  step = fps * 360/time
  redraw = {}

  erase = ->
    window.clearTimeout redraw
    this.setAttribute "d", ''
    a = 0

  draw = ->
    a += step
    last = a >= 360
    if last
      a = 359.9
    r = (a * pi / 180)
    x = Math.sin(r) * radius
    y = Math.cos(r) * -radius

    mid = if (a > 180) then 1 else 0
    anim = "M 0 -#{radius} A #{radius} #{radius} 0 #{mid} 1 #{x} #{y}"
    if last
      anim += " z"

    this.setAttribute "d", anim
    unless last
      redraw = setTimeout draw.bind(@), fps

  $('[data-fancy-hover]').each ->
    path = $(@).find('path')[0]
    $(@).mouseenter draw.bind(path)
    $(@).mouseleave erase.bind(path)

  for item in $('[data-scroll]').get()
    $(item).click -> scrollTo $(item).data("scroll")
