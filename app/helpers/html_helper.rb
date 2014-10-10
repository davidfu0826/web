module HtmlHelper
  include AutoHtml

  def process_into_html content
    auto_html content do
      image_caption
      redcarpet
      indentation
      youtube(autoplay: false, class: "embed-responsive embed-responsive-16by9")
      podio_webforms
      google_docs_forms
      responsive_iframes
      responsive_images
    end
  end

  def news_html content
    auto_html content do
      sanitize
      strip_image_tags
      redcarpet
      indentation
      simple_format
      first_paragraph
    end
  end
end
