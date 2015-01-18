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

  // core functions: range
  var range = $.summernote.core.range;
  var dom = $.summernote.core.dom;

  /**
   * createVideoNode
   *
   * @param {String} url
   * @return {Node}
   */
  var createFormNode = function (url) {
    // form url patterns
    var pfRegExp = /^https:\/\/podio.com\/webforms\/[0-9]+\/([0-9]+)/;
    var pfMatch = url.match(pfRegExp);

    var gfRegExp = /^https:\/\/docs.google.com\/forms\/d\/[^\/]+\//;
    var gfMatch = url.match(gfRegExp);

    var $form;
    if (pfMatch && pfMatch[0].length) {
      $form = $('<iframe>')
        .attr('src', pfMatch[0])
        .attr('height', '600')
        .attr('width', '100%')
        .attr('frameborder', '0')
        .attr('marginheight', '0')
        .attr('marginwidth', '0')
        .html('Loading...');
    } else if (gfMatch && gfMatch[0].length) {
      $form = $('<iframe>')
        .attr('src', gfMatch[0] + 'viewform?embedded=true')
        .attr('width', '100%')
        .attr('height', '600')
        .attr('frameborder', '0')
        .attr('marginheight', '0')
        .attr('marginwidth', '0')
        .html('Loading...');
    } else {
      // this is not a known form link.
    }

    $form.attr('frameborder', 0);

    return $form[0];
  };

  /**
   * @param {jQuery} $editable
   * @return {String}
   */
  var getTextOnRange = function ($editable) {
    $editable.focus();

    var rng = range.create();

    // if range on anchor, expand range with anchor
    if (rng.isOnAnchor()) {
      var anchor = dom.ancestor(rng.sc, dom.isAnchor);
      rng = range.createFromNode(anchor);
    }

    return rng.toString();
  };

  /**
   * toggle button status
   *
   * @param {jQuery} $btn
   * @param {Boolean} isEnable
   */
  var toggleBtn = function ($btn, isEnable) {
    $btn.toggleClass('disabled', !isEnable);
    $btn.attr('disabled', !isEnable);
  };

  /**
   * Show image dialog and set event handlers on dialog controls.
   *
   * @param {jQuery} $dialog
   * @param {jQuery} $dialog
   * @param {Object} text
   * @return {Promise}
   */
  var showFormDialog = function ($editable, $dialog, text) {
    return $.Deferred(function (deferred) {
      var $formDialog = $dialog.find('.note-form-dialog');

      var $formUrl = $formDialog.find('.note-form-url'),
          $formBtn = $formDialog.find('.note-form-btn');

      $formDialog.one('shown.bs.modal', function () {
        $formUrl.val(text).keyup(function () {
          toggleBtn($formBtn, $formUrl.val());
        }).trigger('keyup').trigger('focus');

        $formBtn.click(function (event) {
          event.preventDefault();

          deferred.resolve($formUrl.val());
          $formDialog.modal('hide');
        });
      }).one('hidden.bs.modal', function () {
        $formUrl.off('keyup');
        $formBtn.off('click');

        if (deferred.state() === 'pending') {
          deferred.reject();
        }
      }).modal('show');
    });
  };

  // add plugin
  $.summernote.addPlugin({
    name: 'form', // name of plugin

    buttons: { // buttons
      form: function () {
        return tmpl.iconButton('fa fa-check-square-o', {
          event: 'showFormDialog',
          title: 'Form',
          hide: false
        });
      }
    },

    dialogs: {
      /**
       * @param {Object} lang
       * @param {Object} options
       * @return {String}
       */
      form: function (lang) {
        var body = '<div class="form-group row-fluid">' +
                     '<label>' + lang.form.url + ' <small class="text-muted">' + lang.form.providers + '</small></label>' +
                     '<input class="note-form-url form-control span12" type="text" />' +
                   '</div>';
        var footer = '<button href="#" class="btn btn-primary note-form-btn disabled" disabled>' + lang.form.insert + '</button>';
        return tmpl.dialog('note-form-dialog', lang.form.insert, body, footer);
      }
    },

    events: { // events
      showFormDialog: function (layoutInfo) {
        var $dialog = layoutInfo.dialog(),
            $editable = layoutInfo.editable(),
            text = getTextOnRange($editable);

        // save current range
        editor.saveRange($editable);

        showFormDialog($editable, $dialog, text).then(function (url) {
          // when submit button clicked

          // restore range
          editor.restoreRange($editable);

          // insert image
          editor.insertNode($editable, createFormNode(url));
        }).fail(function () {
          // when cancel button clicked
          editor.restoreRange($editable);
        });
      }
    },

    // define language
    langs: {
      'en-US': {
        form: {
          form: 'Form',
          formLink: 'Form Link',
          insert: 'Insert form',
          url: 'Form URL?',
          providers: '(Google forms or Podio webforms)'
        }
      },
      'sv-SE': {
        form: {
          form: 'Formulär',
          formLink: 'Länk till formuläret',
          insert: 'Infoga formulär',
          url: 'Länk till formuläret',
          providers: '(Google forms eller Podio webforms)'
        }
      }
    }
  });
}));
