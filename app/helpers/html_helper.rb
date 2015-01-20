module HtmlHelper
  include AutoHtml

  def process_into_html content
    auto_html content do
      redcarpet
      image_caption
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
      first_paragraph
      #sanitize
      #strip_image_tags
      #redcarpet
      #indentation
      #simple_format
    end
  end
end
