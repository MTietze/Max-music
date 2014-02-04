$ ->
  $(document).on "click", "#songs th a, #songs .pagination a",  ->
    $.getScript @href
    false
  $(document).on 'submit', '#songs_search', ->
    $.get @action, $(this).serialize(), null, 'script'
    false