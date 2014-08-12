host PUBLIC_URL

sitemap :site do
  url root_url, last_mod: Time.now, change_freq: "daily", priority: 1.0
end

sitemap_for Page.all
sitemap_for Post.all
sitemap_for Event.all

# Ping search engines after sitemap generation:
#
#   ping_with "http://#{host}/sitemap.xml"
