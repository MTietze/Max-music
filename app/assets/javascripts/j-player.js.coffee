$(document).on 'ready', ->
  next = '#'
  $("#jquery_jplayer_1").jPlayer
    ready: ->
      $(this).jPlayer "setMedia",
        m4a: "#"
    ended: -> 
      next.trigger('click')    

    swfPath: "/assets/jQuery.jPlayer.2.5.0"
    supplied: "m4a"
    solution: "html, flash"
  
  $(document).on "click", "a.listen",  ->
    $this = $(this)
    next = $this.parents("tr").next().find(".listen")
    url = $this.attr("href")
    title = $this.parents("tr").data("title")
    $("#jquery_jplayer_1").jPlayer("setMedia",
      m4a: url
    ).jPlayer "play"
    $("#jptitle").text title
    $("#blurb").text $this.parents('tr').data('blurb')
    ga 'send', 'event', 'Songs', 'listen', title
    false

  $(document).on "click", "a.download",  ->
    title = $this.parents("tr").data("title")
    ga 'send', 'event', 'Songs', 'download', title


