$ ->
  $('textarea.wmd-input').each (i, input) ->
    attr = $(input).attr('id').split('wmd-input')[1]
    converter = new Markdown.Converter()
    converter.hooks.chain "plainLinkText", transform_urls
    converter.hooks.chain "postConversion", identifyImages
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
  sanitizeImageTag = (tag) ->
    # chops off the last char in the string ('>') and replaces it
    # with the class name we want to add
    if tag.match(/^<img.*>$/i)
      tag.slice(0, tag.length - 1) + " class=\"img-responsive\">"
    else
      tag
  html.replace /<[^>]*>?/g, sanitizeImageTag

insertImageDialog = (callback) ->
  setTimeout ( ->
    selected_image = null
    $("#imageModal").modal "show"
    $(".img-select").click (e) ->
      loadImageSelection e, selected_image

    $("#image-select-body").on "imageSelection", (e, image) ->
      selected_image = image
    $("#image-select-body").change (e) ->
      $(".img-select").click (ev) ->
        loadImageSelection ev, selected_image

    $("#img-submit").click (e) ->
      $("#imageModal").modal "hide"
      $(".img-select-active").removeClass 'img-select-active'
      value = selected_image.attributes['data-source'].value
      selected_image = null
      callback(value)
    $("#modal-close").click (e) ->
      $("#imageModal").modal "hide"
      $(".img-select-active").removeClass 'img-select-active'
      selected_image = null
      callback(null)
  ), 0
  true

loadImageSelection = (e, selected_image) ->
  if selected_image != null
    $(selected_image).toggleClass 'img-select-active'
  selected_image = e.target
  $(selected_image).toggleClass 'img-select-active'
  $("#image-select-body").trigger "imageSelection", selected_image

transform_urls = (url) ->
  if /^https:\/\/podio\.com\/webforms\//i.test(url)
    #id = url.split("/").pop()
    #script = "<script src=#{url}.js></script>"+"<script type='text/javascript'>_podioWebForm.render(#{id})</script>"
    "<b>Podio Webform</b>"
  else if /^https:\/\/docs\.google\.com\/forms\//i.test(url)
    "<b>Google Docs Form</b>"
  else
    url
