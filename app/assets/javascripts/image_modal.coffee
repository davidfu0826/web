$(document).on "page:change", ->
  $("#insertImageModal").on "show.bs.modal", (e) ->
    $("[type='file']").fileinput
      showUpload: false,
      showRemove: false
  $("#image-button").click showImageLibraryDialog

showImageLibraryDialog = ->
  $imageDialog = $("#insertImageModal")
  $imageDialog.one("shown.bs.modal", ->
    $imageDialog.on "image_uploaded", null, (event) ->
      $imageDialog.modal "hide"
      $('[id*="image_id"]').attr('value', event.image_id)
      $('#preview-image').attr('src', event.image_source)

    $("#insert-image").click (event) ->
      event.preventDefault()
      $('[id*="image_id"]').attr('value',
        $(".img-selected").data("image-id"))
      $('#preview-image').attr('src',
        $(".img-selected").data("image-source"))

      $(".img-selected").removeClass "img-selected"
      $imageDialog.modal "hide"
  ).one("hidden.bs.modal", ->
    $imageDialog.off "image_uploaded"
    $("#insert-image").off "click"
  ).modal "show"
