$(document).on("turbolinks:load", function() {
  $('.datepicker').datetimepicker({
    format: 'YYYY-MM-DD'
  });

  $('#event_start_time').datetimepicker();
  $('#event_end_time').datetimepicker({
    useCurrent: false //Important! See issue #1075
  });

  $("#event_start_time").on("dp.change", function (e) {
    $('#event_end_time').data("DateTimePicker").minDate(e.date);

    // if end_time is empty
    if ($('#event_end_time').data("DateTimePicker").date() == null) {
      $('#event_end_time').data("DateTimePicker").date($("#event_start_time").data("DateTimePicker").date().add(3, 'hours'));
    } else {
      interval = $('#event_end_time').data("DateTimePicker").date()-e.oldDate;
      new_date = $('#event_start_time').data("DateTimePicker").date().add(interval, 'ms');
      $('#event_end_time').data("DateTimePicker").date(new_date);
    }
  });
});
