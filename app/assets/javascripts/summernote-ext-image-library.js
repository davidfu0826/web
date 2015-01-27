(function (factory) {
  /* global define */
  if (typeof define === 'function' && define.amd) {
    // AMD. Register as an anonymous module.
    define(['jquery'], factory);
  } else {
    // Browser globals: jQuery
    factory(window.jQuery);
  }
}(function ($) {
  // template, editor
  var tmpl = $.summernote.renderer.getTemplate();
  var editor = $.summernote.eventHandler.getEditor();

  /**
   * Show image dialog.
   *
   * @param {jQuery} $dialog
   * @param {jQuery} $dialog
   * @return {Promise}
   */
  var showImageLibraryDialog = function ($editable, $dialog) {
    return $.Deferred(function (deferred) {
      var $imageDialog = $('#insertImageModal');

      $imageDialog.one("shown.bs.modal", function() {
        $imageDialog.on("image_uploaded", null, function(event) {
          deferred.resolve(event.image_source);
          $imageDialog.modal("hide");
        });

        $('#insert-image').click(function(event) {
          var image_source;
          event.preventDefault();
          $image = $('.img-selected');

          if ($image.length > 1) {
            image_sources = $.map($image, function(image, i) {
              return $(image).data('image-source'); }
            );
            deferred.resolve(image_sources);
          } else {
            image_source = $('.img-selected').data('image-source');
            deferred.resolve(image_source);
          };
          $('.img-selected').removeClass('img-selected');
          $imageDialog.modal("hide");
        });
      }).one('hidden.bs.modal', function() {
        // Reset attribute fields
        $('#image-link').val('');
        $('#image-caption').val('');
        // Remove event handlers
        $imageDialog.off("image_uploaded");
        $('#insert-image').off("click");
        // Reject promise
        if (deferred.state() === "pending") {
          deferred.reject();
        }
      }).modal("show");
    });
  };

  /**
   * createVideoNode
   *
   * @param {Array} image_urls
   * @return {Node}
   */
  var createCarouselNode = function (image_urls) {
    var random_id = Math.floor((Math.random() * 1000) + 1);

    $carousel = $('<div contenteditable="false">')
      .attr('id', 'carousel-' + random_id)
      .attr('class', 'carousel slide')
      .attr('data-ride', 'carousel');

    $indicators = $('<ol class="carousel-indicators">');
    $slides = $('<div class="carousel-inner" role="listbox">');

    $.each(image_urls, function (index, value) {
      // Add indicator for item
      $indicator = $('<li>')
        .attr('data-target', '#carousel-' + random_id)
        .attr('data-slide-to', index);
      if (index == 0) {
        $indicator.addClass('active');
      };
      $indicators.append($indicator[0]);
      // Add slide for item
      $slide = $('<div class="item">')
        .append($('<img>').attr('src', value));
      if (index == 0) {
        $slide.addClass('active');
      };

      $slides.append($slide[0]);
    });
    $carousel.append($indicators[0]).append($slides[0])
      .append($('<a class="left carousel-control" href="#carousel-'+random_id+'" role="button" data-slide="prev"><span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span></a><a class="right carousel-control" href="#carousel-'+random_id+'" role="button" data-slide="next"><span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span></a>'));

    return $carousel[0];
  };

  /**
   * createImageNode
   *
   * @param {String} image_urls
   * @param {String} link
   * @param {String} caption
   * @return {Node}
   */
  var createImageNode = function (image_src, link, caption) {
    $node = $('<img>')
      .attr('src', image_src)
      .addClass('img-responsive');

    if (typeof(link) != "undefined" && link.length > 0) {
      $node = $('<a>')
        .attr('href', link)
        .append($node);
    };

    if (typeof(caption) != "undefined" && caption.length > 0) {
      $node = $('<figure>')
        .append($node)
        .append($('<figcaption>').text(caption));
    };

    return $node[0];
  };

  // add plugin
  $.summernote.addPlugin({
    name: 'image_library', // name of plugin

    buttons: { // buttons
      image_library: function () {
        return tmpl.iconButton('fa fa-picture-o', {
          event: 'showImageLibraryDialog',
          title: 'Image Library',
          hide: false
        });
      }
    },

    events: { // events
      showImageLibraryDialog: function (layoutInfo) {
        var $dialog = layoutInfo.dialog(),
            $editable = layoutInfo.editable();

        // save current range
        editor.saveRange($editable);

        showImageLibraryDialog($editable).then(function (url) {
          // when submit button clicked
          // restore range
          editor.restoreRange($editable);

          // Insert image, or insert image carousel
          if ($.isArray(url)) {
            editor.insertNode($editable, createCarouselNode(url));
          } else {
            var link = $('#image-link').val();
            var caption = $('#image-caption').val();

            //editor.insertImage($editable, url);
            editor.insertNode($editable, createImageNode(url, link, caption));
          };
        }).fail(function () {
          // when cancel button clicked
          editor.restoreRange($editable);
        });
      }
    }
  });
}));
