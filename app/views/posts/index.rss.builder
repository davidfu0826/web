xml.instruct! :xml, version: "1.0"
xml.rss version: "2.0" do
  xml.channel do
    xml.title "TLTH"
    xml.description "Teknologkåren LTH"
    xml.link posts_url

    @posts.each do |post|
      xml.item do
        xml.title post.title
        xml.description truncate(post.first_paragraph, length: 250)
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link post_url(post)
        xml.guid post_url(post)
      end
    end
  end
end
