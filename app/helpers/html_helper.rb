module HtmlHelper
  include AutoHtml

  def process_into_html content
    filters
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

  private

  def filters
    AutoHtml.add_filter(:podio_webforms) do |link|
      link.gsub(/https:\/\/podio\.com\/webforms\/([0-9]*)\/([0-9]*)(\/)?/) do |url|
        id = url.split('/').last
        %{
          <div class="podio-webform-container">
            <script src="#{url}.js"></script>
            <script type="text/javascript">$(window).load(function(){_podioWebForm.render("#{id}"); console.log("hej"); })</script>
          </div>
        }
      end
    end
    AutoHtml.add_filter(:google_docs_forms) do |link|
      link.gsub(/https:\/\/docs\.google\.com\/forms\/d\/\w+\//) do |url|
        %{<iframe class="embed-responsive-item" src="#{url}viewform?embedded=true"></iframe>}
      end
    end
    AutoHtml.add_filter(:responsive_iframes) do |text|
      text.gsub(/<iframe.+<\/iframe>/) do |match|
        %{<div class="embed-responsive embed-responsive-4by3">#{match}</div>}
      end
    end
    AutoHtml.add_filter(:responsive_images) do |text|
      text.gsub(/<img[^>]+/) do |match|
        %{#{match} class="img-responsive"}
      end
    end
  end

end
