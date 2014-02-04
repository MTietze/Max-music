$(document).on 'ready', ->
  $("#jquery_jplayer_1").jPlayer
    ready: ->
      $(this).jPlayer "setMedia",
        m4a: "#"


    swfPath: "/assets/jQuery.jPlayer.2.5.0"
    supplied: "m4a"
    solution: "html, flash"
  
  $(document).on "click", "a.listen",  ->
    url = $(this).attr("href")
    $("#jquery_jplayer_1").jPlayer("setMedia",
      m4a: url
    ).jPlayer "play"
    $("#jptitle").text $(this).parents("tr").data("title")
    $("#blurb").text $(this).parents('tr').data('blurb')
    false
