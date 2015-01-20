$(document).on "page:change", ->
  $('#save-nav-item-order').click post_nav_item_order

  $('.remove_link_field').click remove_link_field
  $('#add_link_field').click ->
    count = $('#sidebar-link-forms').attr 'data-count'
    $('#sidebar-link-forms').attr('data-count', $('#sidebar-link-forms').data('count') + 1)
    $('#sidebar-link-forms').append(
      $('<div id="link-row-'+count+'" class="row">
          <div class="col-md-4"><div class="form-group">' +
            '<label class="control-label" for="_settings_sidebar_links['+count+'][title]">Titel</label>' +
            '<input class="form-control" type="text" name="[settings][sidebar_links['+count+'][title]]"' +
              'id="_settings_sidebar_links['+count+'][title]">' +
              '</div>' +
            '</div>' +
          '<div class="col-md-6">' +
            '<div class="form-group">' +
              '<label class="control-label" for="_settings_sidebar_links['+count+'][url]">URL</label>' +
              '<input class="form-control" type="text"' +
                'name="[settings][sidebar_links['+count+'][url]]" id="_settings_sidebar_links['+count+'][url]">' +
            '</div>' +
          '</div>' +
          '<div class="col-md-2" style="margin-top: 35px;">' +
            '<a class="remove_link_field" data-field="'+count+'" href="#">Remove</a>' +
          '</div>' +
        '</div>'))
    $('.remove_link_field').click remove_link_field

  # Form helpers
  $('#colorpicker').minicolors theme: 'bootstrap'
  $("[type='file']").fileinput
    showUpload: false,
    showRemove: false

  $("[data-behaviour~=datepicker]").datetimepicker
    language: "sv"
    autoclose: true
    todayHighlight: true
    pick12HourFormat: false

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
      ['help', ['help']]
    ]


  tag_data = select2_tags()
  # Used in image modal
  $(".img-select").click (event) ->
    $(event.currentTarget).toggleClass('img-selected')
  $("#insertImageModal").on "show.bs.modal", (e) ->
    $("[type='file']").fileinput
      showUpload: false,
      showRemove: false
    select2_tags()

select2_tags =  ->
  # Inserting tags
  tag_data = []
  $(".tag_select").select2
    placeholder: "Search for or input a new tag"
    tags: ->
      if tag_data.length == 0
        $.ajax(url: "/tags.json").done (data) ->
          tag_data = $.map(data, (tag) ->
            tag.title
        )
      else
        tag_data
    tokenSeparators: [",", " "]

remove_link_field = ->
  $(event.currentTarget).parent().parent().remove()
  $('#sidebar-link-forms').attr('data-count', $('#sidebar-link-forms').data('count') - 1)

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
