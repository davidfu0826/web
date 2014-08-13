module HtmlHelper
  include AutoHtml

  def process_into_html content
    auto_html content do
      sanitize
      redcarpet
      youtube(autoplay: false, class: "embed-responsive embed-responsive-16by9")
      podio_webforms
      google_docs_forms
      responsive_iframes
      responsive_images
      simple_format
    end
  end

  def news_html content
    auto_html content do
      sanitize
      strip_image_tags
      redcarpet
      simple_format
      first_paragraph
    end
  end
end
