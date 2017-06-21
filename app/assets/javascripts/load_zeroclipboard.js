function clipboard() {
  var client = new ZeroClipboard($(".copy-link"));
  client.on( "ready", function( readyEvent ) {
    client.on('aftercopy', function(event) {
      var elm = event.target.parentNode.getElementsByClassName('copy-status')[0];
      if (elm != null) {
        $('.copy-status').hide();
        $('.global-copy-status').hide();
        elm.innerHTML = 'Kopierat!';
        elm.style.display = 'block';
      } else {
        $('.copy-status').hide();
        $('.global-copy-status').html("Kopierade: \n" + event.data["text/plain"]);
        $('.global-copy-status').show();
      }
    });
  });
  $(".copy-link").click( function() {
    return false;
  });
}

$(document).on('turbolinks:load', clipboard);
