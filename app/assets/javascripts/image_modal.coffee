jQuery ->
  $("#imageModal").on "show.bs.modal", (e) ->
    $("[type='file']").fileinput
      showUpload: false,
      showRemove: false
  $("#image-button").click ->
    insertImageDialog set_image, true
  $("#imageModal").find("a[data-toggle='tab']").on "shown.bs.tab", (e) ->
    $("#imageModal").find("#img-submit").toggleClass "disabled"

set_image = (image) ->
  $("#preview-image").attr "src", image.source
  $("[id*='_image_id']").val image.id

#Called from both above and in pagedown.js.coffee
@insertImageDialog = (callback, return_multiple_values) ->
  console.log callback
  setTimeout ( ->
    selected_image = null
    $("#imageModal").modal "show"
    $(".img-select").click (e) ->
      loadImageSelection e, selected_image
    $("#image-select-body").on "imageSelection", (e, image) ->
      selected_image = image
    $("#image-select-body").change (e) ->
      $(".img-select").click (ev) ->
        loadImageSelection ev, selected_image

    #An image was uploaded
    $("#image-upload-tab").on "image_uploaded", null, (e, image) ->
      $("#imageModal").modal "hide"
      values =
        id: e.image_id
        source: e.image
      selected_image = null
      console.log return_multiple_values
      console.log values.source
      if return_multiple_values
        callback values
      else
        callback values.source

    #An image was submitted using the library
    $("#img-submit").click (e) ->
      $("#imageModal").modal "hide"
      $(".img-select-active").removeClass "img-select-active"
      values =
        id: selected_image.attributes["data-id"].value
        source: selected_image.attributes["data-source"].value
      selected_image = null
      if return_multiple_values
        callback values
      else
        callback values.source

    #The modal was closed
    $("#modal-close").click (e) ->
      $("#imageModal").modal "hide"
      $(".img-select-active").removeClass "img-select-active"
      selected_image = null
      callback null
  ), 0
  true

loadImageSelection = (e, selected_image) ->
  if selected_image != null
    $(selected_image).toggleClass 'img-select-active'
  selected_image = e.target
  $(selected_image).toggleClass 'img-select-active'
  $("#image-select-body").trigger "imageSelection", selected_image
