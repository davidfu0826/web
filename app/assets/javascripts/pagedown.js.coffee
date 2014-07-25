$ ->
  $('textarea.wmd-input').each (i, input) ->
    console.log input
    attr = $(input).attr('id').split('wmd-input')[1]
    console.log attr
    converter = new Markdown.Converter()
    Markdown.Extra.init(converter)
    help =
      handler: () ->
        window.open('http://daringfireball.net/projects/markdown/syntax')
        return false
      title: "<%= I18n.t('components.markdown_editor.help', default: 'Markdown Editing Help') %>"
    editor = new Markdown.Editor(converter, attr, help)
    editor.hooks.set "insertImageDialog", (callback) ->
      setTimeout ( ->
          $("#myModal").modal "show"
          $(".img-choose").click (e) ->
            $("#myModal").modal "hide"
            console.log(e.target.attributes['data-source'].value)
            callback(e.target.attributes['data-source'].value)
          $("#modal-close").click (e) ->
            $("#myModal").modal "hide"
            callback(null)
      ), 0
      true
    editor.run()
