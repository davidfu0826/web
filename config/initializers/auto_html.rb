AutoHtml.add_filter(:podio_webforms) do |link|
  link.gsub(/f{https:\/\/podio\.com\/webforms\/[^}]+}/) do |url|
    url = url[2..(url.length - 2)]
    id = url.split('/').last
    %{
      <script src="#{url}.js"></script>
      <script type="text/javascript">_podioWebForm.render("#{id}")</script>
    }
  end
end

AutoHtml.add_filter(:google_docs_forms) do |link|
  link.gsub(/f{https:\/\/docs\.google\.com\/forms\/d\/[^}]+}/) do |url|
    url = url[2..(url.length - 2)]
    %{<iframe class="embed-responsive-item" src="#{url}viewform?embedded=true"></iframe>}
  end
end

AutoHtml.add_filter(:responsive_iframes) do |text|
  text.gsub(/<iframe.+<\/iframe>/) do |match|
    %{<div class="embed-responsive embed-responsive-16by9">#{match}</div>}
  end
end

AutoHtml.add_filter(:responsive_images) do |text|
  text.gsub(/<img[^>]+/) do |match|
    %{#{match} class="img-responsive"}
  end
end

AutoHtml.add_filter(:indentation) do |text|
  text.gsub(/---/) do |match|
    %{&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}
  end
end

AutoHtml.add_filter(:strip_image_tags) do |text|
  text.gsub(/!\[\S+\]\[\d+\]/) do |match|
    %{}
  end
end

AutoHtml.add_filter(:image_caption) do |text|
  text.gsub(/<img[^>]+>/) do |match|
    alt_tag = match.match(/alt="[^"]+"/).to_s
    desc = alt_tag[5..(alt_tag.length - 2)]
    %{<figure>#{match}<figcaption>#{desc}</figcaption></figure>}
  end
end

AutoHtml.add_filter(:first_paragraph) do |text|
  Nokogiri::HTML.parse(text).css('p').children.first.text
end
