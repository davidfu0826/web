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
//= require_tree .


$(document).ready(function(){
  $("#twitter-feed").load("/tweets");
  $('#colorpicker').minicolors({
    theme: 'bootstrap'
  });
  $('#post-image-button').click(function() {
    insertImageDialog(set_image);
  });
  load_datepicker();
  load_select2();
});

$(document).delegate('*[data-toggle="lightbox"]', 'click', function(event) {
    event.preventDefault();
    $(this).ekkoLightbox();
});

function set_image(image) {
  $('#post-image').attr('src', image['source']);
  $('#post_image_id').val(image['id']);
}

function load_datepicker() {
  $('[data-behaviour~=datepicker]').datetimepicker({
    language: 'sv',
    autoclose: true,
    todayHighlight: true,
    pick12HourFormat: false
  });
}

function load_select2() {
  var sel = document.querySelectorAll("#select2");
  for (index = 0; index < sel.length; ++index) {
    $(sel[index]).select2();
  }
}

var insertImageDialog, loadImageSelection;

insertImageDialog = function(callback) {
  setTimeout((function() {
    var selected_image;
    selected_image = null;
    $("#imageModal").modal("show");
    $(".img-select").click(function(e) {
      return loadImageSelection(e, selected_image);
    });
    $("#image-select-body").on("imageSelection", function(e, image) {
      return selected_image = image;
    });
    $("#image-select-body").change(function(e) {
      return $(".img-select").click(function(ev) {
        return loadImageSelection(ev, selected_image);
      });
    });
    $("#img-submit").click(function(e) {
      var value;
      $("#imageModal").modal("hide");
      $(".img-select-active").removeClass('img-select-active');
      values = {
        'id':     selected_image.attributes['data-id'].value,
        'source': selected_image.attributes['data-source'].value
      };
      selected_image = null;
      return callback(values);
    });
    return $("#modal-close").click(function(e) {
      $("#imageModal").modal("hide");
      $(".img-select-active").removeClass('img-select-active');
      selected_image = null;
      return callback(null);
    });
  }), 0);
  return true;
};

loadImageSelection = function(e, selected_image) {
  if (selected_image !== null) {
    $(selected_image).toggleClass('img-select-active');
  }
  selected_image = e.target;
  $(selected_image).toggleClass('img-select-active');
  return $("#image-select-body").trigger("imageSelection", selected_image);
};
