$(document).on "page:change", ->
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

remove_link_field = ->
  $(event.currentTarget).parent().parent().remove()
  $('#sidebar-link-forms').attr('data-count', $('#sidebar-link-forms').data('count') - 1)
