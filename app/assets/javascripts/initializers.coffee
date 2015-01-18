$(document).on "page:change", ->
  $("#twitter-feed").load "/tweets"
  $('#colorpicker').minicolors theme: 'bootstrap'
  $("[type='file']").fileinput
    showUpload: false,
    showRemove: false
  $('.select2').select2
  $("[data-behaviour~=datepicker]").datetimepicker
    language: "sv"
    autoclose: true
    todayHighlight: true
    pick12HourFormat: false

  $(".img-select").click (event) ->
    $(event.currentTarget).toggleClass('img-selected')

  $('.summernote_editor').summernote
    height: 400
    codemirror:
      lineNumbers: true
      tabSize: 2
      theme: "solarized light"
    toolbar: [
      ['style', [ 'style',]],
      ['format', [ 'bold', 'italic', 'underline', 'strikethrough', 'clear']],
      ['layout', ['ul', 'ol']],
      ['para', ['ul', 'ol', 'paragraph']],
      ['insert', ['link', 'image_library', 'table', 'hr', 'form']],
      ['controls', ['undo', 'redo']],
      ['misc', ['fullscreen', 'codeview']],
      ['help', ['help']],
    ]

