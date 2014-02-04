Resize = ->
  $('body').height($(document).height());
  
$(document).on 'ready', ->
  Resize()
  $(window).on("resize", Resize)