function select2() {
  $('.select2').select2({
    theme: 'bootstrap',
    width: '100%'
  });
}

function select2Tags() {
  $('.select2_tags').select2({
    tags: true,
    theme: 'bootstrap',
    width: '100%'
  });
}

// Clear all select2 insertions before caching to avoid double loading.
function clearSelect2() {
  return $('.form-control.select2').each(function() {
    return $(this).select2('destroy');
  });
  return $('.form-control.select2_tags').each(function() {
    return $(this).select2('destroy');
  });
}

$(document).on('turbolinks:load', select2);
$(document).on('turbolinks:load', select2Tags);
$(document).on('turbolinks:before-cache', clearSelect2);
