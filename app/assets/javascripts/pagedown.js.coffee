$ ->
  $('textarea.wmd-input').each (i, input) ->
    console.log input
    attr = $(input).attr('id').split('wmd-input')[1]
    converter = new Markdown.Converter()
    Markdown.Extra.init(converter)
    help =
      handler: () ->
        window.open('http://daringfireball.net/projects/markdown/syntax')
        return false
      title: "<%= I18n.t('components.markdown_editor.help', default: 'Markdown Editing Help') %>"
    editor = new Markdown.Editor(converter, attr, help)
    editor.run()
