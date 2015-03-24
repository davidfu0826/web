module CacheHelper

  def is_homepage?
    request.original_fullpath == '/'
  end

  def cache_key_navbar
    locale = I18n.locale
    count          = NavItem.count
    max_updated_at = NavItem.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "application/navbar-#{locale}-#{count}-#{max_updated_at}"
  end

  def cache_key_navbar_items
    locale = I18n.locale
    count          = NavItem.count
    max_updated_at = NavItem.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "nav_items/all-#{locale}-#{count}-#{max_updated_at}"
  end

  def cache_key_posts_index
    locale = I18n.locale
    count          = Post.count
    max_updated_at = Post.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "posts/index-#{locale}-#{count}-#{max_updated_at}"
  end

  def cache_key_homepage_posts
    locale = I18n.locale
    count          = Post.count
    max_updated_at = Post.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "posts/homepage-#{locale}-#{count}-#{max_updated_at}"
  end

  def cache_key_sidebar
    cache_key_sidebar_links + cache_key_sidebar_events
  end

  def cache_key_sidebar_links
    locale = I18n.locale
    updated_at = Settings.find_by(var: :sidebar_links).updated_at
    "application/sidebar_links-#{locale}-#{updated_at}"
  end

  def cache_key_sidebar_events
    locale = I18n.locale
    count          = Event.count
    max_updated_at = Event.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "events/sidebar-#{locale}-#{count}-#{max_updated_at}"
  end

  def cache_key_banner_carousel
    locale = I18n.locale
    updated_at = Settings.find_by(var: :promoted_pages).updated_at
    "application/banner_carousel-#{locale}-#{updated_at}"
  end
end
