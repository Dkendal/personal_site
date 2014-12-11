scrollTo = (str) ->
  $('html, body').animate({scrollTop: $(str).offset().top}, 500, "linear")

introAnim = (name) -> $("[data-anim='intro-#{name}']")

$.fn.chain = (callback) ->
  this.one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', callback)

 $ ->

  $name = introAnim "name"
  $bar = introAnim "bar"
  $sub = introAnim "sub"

  $name.addClass("animated fadeIn")

  window.setTimeout ( -> $bar.addClass("animated fadeInUp") ), 300
  window.setTimeout ( -> $sub.addClass("animated fadeInUp") ), 400

  $('[data-scroll]').each ->
    $(this).click -> scrollTo $(this).data("scroll")
