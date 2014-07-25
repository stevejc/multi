ready = ->
  
  # makes tr's clickable
  $("tr[data-link]").click ->
    window.location = @dataset.link
    return

  return

$(document).ready(ready)
$(document).on('page:load', ready)
