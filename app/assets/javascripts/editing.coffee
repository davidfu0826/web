$(document).on "turbolinks:load", ->
  $('#save-nav-item-order').click post_nav_item_order

  fileinput($("[type='file']"))

  $("[data-behaviour~=datepicker]").datetimepicker
    language: "sv"
    autoclose: true
    todayHighlight: true
    pick12HourFormat: false

  $('.summernote_editor').summernote
    lang: 'sv-SE'
    height: 400
    codemirror:
      lineNumbers: true
      tabSize: 2
      theme: "solarized light"
    toolbar: [
      ['style', [ 'style',]],
      ['format', [ 'bold', 'italic', 'underline', 'strikethrough', 'clear']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['insert', ['link', 'picture', 'hr', 'table']],
      ['controls', ['undo', 'redo']],
      ['misc', ['fullscreen', 'codeview']],
      ['help', ['help']]
    ]

  # Used in image modal
  $(".img-select").click (event) ->
    $(event.currentTarget).toggleClass('img-selected')

fileinput = (input) ->
  if input.length == 0
    return
  if $(input).attr('id').indexOf('image') > -1
    allowedFileExtensions = ['jpeg', 'jpg', 'png', 'bmp', 'gif']
  else
    allowedFileExtensions = null
  input.fileinput
    showUpload: false,
    showRemove: false,
    allowedFileExtensions: allowedFileExtensions

post_nav_item_order = ->
  data = $('.dd').nestable 'serialize'
  json_data = JSON.stringify(data)
  $.ajax
    type: "POST",
    url: "/nav_items/update_order",
    data: { nav_item_data: json_data},
    success: ->
      return false
    error: ->
      return false
