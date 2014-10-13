$ ->
  $('textarea.wmd-input').each (i, input) ->
    attr = $(input).attr('id').split('wmd-input')[1]
    converter = new Markdown.Converter()
    converter.hooks.chain "preConversion", transform_podio
    converter.hooks.chain "preConversion", transform_google
    converter.hooks.chain "postConversion", identifyImages
    converter.hooks.chain "postConversion", indentation
    Markdown.Extra.init(converter)
    help =
      handler: () ->
        window.open('http://daringfireball.net/projects/markdown/syntax')
        return false
      title: "<%= I18n.t('components.markdown_editor.help', default: 'Markdown Editing Help') %>"
    editor = new Markdown.Editor(converter, attr, help)
    editor.hooks.set "insertImageDialog", insertImageDialog
    editor.run()

identifyImages = (html) ->
  formatImageTag = (tag) ->
    # chops off the last char in the string ('>') and replaces it
    # with the class name we want to add
    # Also gets the alt tag and sets it as a caption
    if tag.match(/^<img.*>$/i)
      tag = tag.slice(0, tag.length - 1) + " class=\"img-responsive\">"
      alt_tag = tag.match(/alt="[^"]+"/g)
      desc = alt_tag[0].slice(5, alt_tag.length - 2)
      "<figure>" + tag + "<figcaption>" + desc + "</figcaption></figure>"
    else
      tag
  html.replace /<[^>]*>?/g, formatImageTag

indentation = (html) ->
  html.replace /---/g, "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"

transform_podio = (html) ->
  html.replace /f{https:\/\/podio\.com\/webforms\/[^}]+}/g, "<b>Podio Webform</b>"
transform_google = (html) ->
  html.replace /f{https:\/\/docs\.google\.com\/forms\/d\/[^}]+}/g, "<b>Google Docs Form</b>"
