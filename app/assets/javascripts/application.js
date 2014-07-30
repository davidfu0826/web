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
//= require jquery.turbolinks
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require bootstrap-datepicker
//= require bootstrap-datepicker/locales/bootstrap-datepicker.sv.js
//= require ekko-lightbox
//= require select2
//= require select2_locale_sv
//= require jquery_nested_form
//= require pagedown_bootstrap
//= require_tree .


$(document).ready(function(){
  load_datepicker();
  load_select2();
})

$(document).ready(function(){
  $( ".img-choose" ).click(function(e) {
    console.log(e.target.src);
    //$('#myModal').modal('hide')
  });
})

$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
    event.preventDefault();
    $(this).ekkoLightbox();
});

function load_datepicker() {
  $('[data-behaviour~=datepicker]').datepicker({
    language: 'sv',
    autoclose: true,
    todayHighlight: true
  });
}

function load_select2() {
  var sel = document.querySelectorAll("#select2");
  for (index = 0; index < sel.length; ++index) {
    $(sel[index]).select2();
  }
}
