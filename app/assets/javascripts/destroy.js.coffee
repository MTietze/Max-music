$(document).on 'ready page:change', ->
  if $('.deletesong').length
    $(document).on 'click', '.deletesong', ->
      $('#destroysong').val($(this).text())