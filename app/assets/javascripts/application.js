//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require turbolinks
//= require bootstrap
//= require moment
//= require moment/sv
//= require bootstrap-datetimepicker
//= require locales/bootstrap-datetimepicker.sv.js
//= require ekko-lightbox
//= require select2
//= require select2_locale_sv
//= require jquery_nested_form
//= require jquery.minicolors
//= require fileinput
//= require codemirror
//= require codemirror/modes/http
//= require codemirror/modes/htmlmixed
//= require summernote
//= require summernote-sv-SE
//= require jquery.nestable
//= require_tree .

$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
  event.preventDefault();
  $(this).ekkoLightbox();
});

$(document).on("page:change", function() {
  $("#twitter-feed").load("/tweets");
  $('.select2').select2();
  $('.dd').nestable({maxDepth: 2});
  $('.dd').nestable('collapseAll');
});



