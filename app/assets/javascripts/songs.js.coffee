$ ->
  $(document).on "click", "#songs th a", ->
    $.getScript @href
    ga 'send', 'event', 'Songs', 'sort', $(this).text()
    false

  $(document).on 'submit', '#songs_search', ->
    $this = $(this)
    $.get @action, $this.serialize(), null, 'script'
    ga 'send', 'event', 'Songs', 'search'
    false

