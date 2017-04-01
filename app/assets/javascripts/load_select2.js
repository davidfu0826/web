function select2() {
  $('.select2').select2({
    debug: true,
    theme: 'bootstrap',
    width: '100%'
  });
}

function select2Tags() {
  $('.select2_tags').select2({
    debug: true,
    tags: true,
    theme: 'bootstrap',
    width: '100%'
  });
}

// Clear all select2 insertions before caching to avoid double loading.
function clearSelect2() {
  $('.select2').select2('destroy');
  $('.select2_tags').select2('destroy');
}

$(document).on('turbolinks:load', select2);
$(document).on('turbolinks:load', select2Tags);
$(document).on('turbolinks:before_cache', clearSelect2);
