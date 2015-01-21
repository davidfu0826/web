$(document).on "page:change", ->
  $(".sidebar").affix offset:
    top: ->
      offset = $(".sidebar").offset().top - 100
      # TODO: Turbolinks makes offset 0 if page is reloaded by f5
      offset = 380  if offset is 0
      @top = offset
    bottom: ->
      @bottom = $(".guilds").outerHeight(true) + $(".footer").outerHeight(true)

