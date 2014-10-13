jQuery ->
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

