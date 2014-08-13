AutoHtml.add_filter(:podio_webforms) do |link|
  link.gsub(/https:\/\/podio\.com\/webforms\/([0-9]*)\/([0-9]*)(\/)?/) do |url|
    id = url.split('/').last
    %{
      <script src="#{url}.js"></script>
      <script type="text/javascript">_podioWebForm.render("#{id}")</script>
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

AutoHtml.add_filter(:strip_image_tags) do |text|
  text.gsub(/!\[\S+\]\[\d+\]/) do |match|
    %{}
  end
end

AutoHtml.add_filter(:first_paragraph) do |text|
  Nokogiri::HTML.parse(text).css('p').children.first.text
end
