# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = PUBLIC_URL
SitemapGenerator::Sitemap.sitemaps_host = Rails.configuration.x.aws_url
SitemapGenerator::Sitemap.public_path = 'tmp/'
SitemapGenerator::Sitemap.sitemaps_path = 'sitemaps/'
SitemapGenerator::Sitemap.adapter = SitemapGenerator::WaveAdapter.new

SitemapGenerator::Sitemap.create do
  add(archive_posts_path)
  add(documents_path)
  add(styrdokument_path)

  Page.where(id: NavItem.joins(:page)
                        .select(:page_id)
                        .distinct
                        .pluck(:page_id)).each do |page|
    add(page_path(page), lastmod: page.updated_at)
  end

  Post.find_each do |post|
    add(post_path(post), lastmod: post.updated_at)
  end

  Event.find_each do |event|
    add(event_path(event), lastmod: event.updated_at)
  end
end
