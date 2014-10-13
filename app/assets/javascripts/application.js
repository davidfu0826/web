// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require bootstrap
//= require moment
//= require moment/sv
//= require bootstrap-datetimepicker
//= require locales/bootstrap-datetimepicker.sv.js
//= require ekko-lightbox
//= require select2
//= require select2_locale_sv
//= require jquery_nested_form
//= require pagedown_bootstrap
//= require jquery.minicolors
//= require fileinput
//= require_tree .

$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
  event.preventDefault();
  $(this).ekkoLightbox();
});
