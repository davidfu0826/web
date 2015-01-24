$(document).on "page:change", ->
  # We don't have to affix if viewport is to small
  if $(window).width() > 1000
    wait_to_affix(0)

  # if we have a banner, reload the affix after a page resize
  # since the banner height will have changed
  if $('#banner').length
    $(window).bind "resizeEnd", ->
      wait_to_affix(0)

# Sometimes the banner is not loaded, so it returns the wrong height
# probably due to turbolinks
wait_to_affix = (count) ->
  if count > 3
    return
  if $('#banner').length && $("#banner").outerHeight(true) < 120
    setTimeout (->
      wait_to_affix(count + 1)
    ), 100
  else
    affix_sidebar()

affix_sidebar = ->
  console.log "Affixing"
  $("#sidebar").affix offset:
    top: ->
      if $('#banner').length
        offset = $("#banner").outerHeight(true) - 50
      else
        offset = 50
      @top = offset
    bottom: ->
      @bottom = $(".guilds").outerHeight(true) + $(".footer").outerHeight(true)

# Don't spam the browser with affix events
$(window).resize ->
  clearTimeout @resizeTO if @resizeTO
  @resizeTO = setTimeout(->
    $(this).trigger "resizeEnd"
  , 500)
