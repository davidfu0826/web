$(document).on "page:change", ->
  $.each $("[id*='sek']", ".guilds"), (index, element) ->
    $(this).hover ( ->
      $(this).css "color", guild_color($(this).attr("id"))
    ), ->
      $(this).css "color", ""
  $('#dokt', '.guilds').hover sourceSwap, sourceSwap

guild_color = (guild) ->
  switch guild
    when "f-sek"
      "#f8931e"
    when "e-sek"
      "black"
    when "m-sek"
      "#ed2024"
    when "v-sek"
      "#3952a4"
    when "a-sek"
      "#91278f"
    when "k-sek"
      "#ffff00"
    when "d-sek"
      "#f280a1"
    when "ing-sek"
      "#2b318b"
    when "w-sek"
      "#6fccdd"
    when "i-sek"
      "#971b1e"

sourceSwap = ->
  $this = $(this)
  newSource = $this.data("alt-src")
  $this.data "alt-src", $this.attr("src")
  $this.attr "src", newSource
