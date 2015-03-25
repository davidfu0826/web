module CacheHelper

  def is_homepage?
    request.original_fullpath == '/'
  end

  def cache_key_navbar
    locale = I18n.locale
    count      = NavItem.count
    updated_at = NavItem.maximum(:updated_at).try(:utc).try(:to_s, :number)
    [locale, "navbar", count, updated_at]
  end

  def cache_key_navbar_items
    locale = I18n.locale
    count      = NavItem.count
    updated_at = NavItem.maximum(:updated_at).try(:utc).try(:to_s, :number)
    [locale, "nav_items/navbar_items", count, updated_at]
  end

  def cache_key_posts_index
    locale = I18n.locale
    role       = current_user.try(:role)
    count      = Post.count
    updated_at = Post.maximum(:updated_at).try(:utc).try(:to_s, :number)
    [locale, "posts/index", role, count, updated_at]
  end

  def cache_key_homepage_posts
    locale = I18n.locale
    role       = current_user.try(:role)
    count      = Post.count
    updated_at = Post.maximum(:updated_at).try(:utc).try(:to_s, :number)
    [locale, "posts/homepage", role, count, updated_at]
  end

  def cache_key_sidebar
    locale = I18n.locale
    is_user    = current_user.nil?
    role       = current_user.try(:role)
    updated_at = Settings.maximum(:updated_at)
    event_count      = Event.count
    event_updated_at = Event.maximum(:updated_at).try(:utc).try(:to_s, :number)
    [locale, "sidebar", is_user, role, updated_at, event_count, event_updated_at]
  end

  def cache_key_sidebar_links
    locale = I18n.locale
    updated_at = Settings.maximum(:updated_at)
    [locale, "sidebar_links", updated_at]
  end

  def cache_key_sidebar_events
    locale = I18n.locale
    count      = Event.count
    updated_at = Event.maximum(:updated_at).try(:utc).try(:to_s, :number)
    [locale, "sidebar_events", count, updated_at]
  end

  def cache_key_banner_carousel
    locale = I18n.locale
    updated_at = Settings.maximum(:updated_at)
    [locale, "banner_carousel", updated_at]
  end

  def cache_key_events_calendar(month)
    locale = I18n.locale
    event_count      = Event.count
    event_updated_at = Event.maximum(:updated_at).try(:utc).try(:to_s, :number)
    [locale, month, event_count, event_updated_at]
  end
end
