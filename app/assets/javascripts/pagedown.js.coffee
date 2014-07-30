$ ->
  $('textarea.wmd-input').each (i, input) ->
    attr = $(input).attr('id').split('wmd-input')[1]
    converter = new Markdown.Converter()
    converter.hooks.chain "plainLinkText", (url) ->
      if /^https:\/\/podio\.com\/webforms\//i.test(url)
        #id = url.split("/").pop()
        #script = "<script src=#{url}.js></script>"+"<script type='text/javascript'>_podioWebForm.render(#{id})</script>"
        "<b>Podio Webform</b>"
      else if /^https:\/\/docs\.google\.com\/forms\//i.test(url)
        "<b>Google Docs Form</b>"
      else
        url
    Markdown.Extra.init(converter)
    help =
      handler: () ->
        window.open('http://daringfireball.net/projects/markdown/syntax')
        return false
      title: "<%= I18n.t('components.markdown_editor.help', default: 'Markdown Editing Help') %>"
    editor = new Markdown.Editor(converter, attr, help)
    editor.hooks.set "insertImageDialog", (callback) ->
      setTimeout ( ->
        $("#imageModal").modal "show"
        $(".img-choose").click (e) ->
          $("#imageModal").modal "hide"
          callback(e.target.attributes['data-source'].value)
        $("#modal-close").click (e) ->
          $("#imageModal").modal "hide"
          callback(null)
      ), 0
      true
    editor.run()

