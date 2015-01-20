include AutoHtml

namespace :html_convert do
  def html_convert content
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

  desc "Converts markdown content to html"
  task all: :environment do
    resources =  Page.all
    resources += Post.all

    resources.each do |resource|
      if resource.content_sv.present?
        resource.content_sv = html_convert(resource.content_sv)
      end
      if resource.content_en.present?
        resource.content_en = html_convert(resource.content_en)
      end
      resource.save!
    end
  end
end
