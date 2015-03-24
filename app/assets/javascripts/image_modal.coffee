$(document).on "page:change", ->
  tag_data = select2_tags()
  $("#insertImageModal").on "show.bs.modal", (e) ->
    select2_tags()
    $("[type='file'][id*='image']").fileinput
      showUpload: false,
      showRemove: false,
      allowedFileExtensions: ['jpeg', 'jpg', 'png', 'bmp', 'gif']
  $("#image-button").click showImageLibraryDialog

showImageLibraryDialog = ->
  $imageDialog = $("#insertImageModal")
  # Hide link and caption fields
  $('#image-attributes').hide()
  # Show dialog
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
    $('#image-attributes').show()
    $imageDialog.off "image_uploaded"
    $("#insert-image").off "click"
  ).modal "show"

# Initialize Select2 for tag autocomplete
select2_tags =  ->
  # Inserting tags
  tag_data = []
  $(".tag_select").select2
    tags: ->
      if tag_data.length == 0
        $.ajax(url: "/tags.json").done (data) ->
          tag_data = $.map(data, (tag) ->
            tag.title
        )
      else
        tag_data
    tokenSeparators: [",", " "]
