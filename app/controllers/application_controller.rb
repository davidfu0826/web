class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_locale
  before_filter :load_nav_items
  before_filter :load_locale


  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def sitemap
    path = Rails.root.join("public", "sitemaps", "sitemap.xml")
    if File.exists?(path)
      render xml: open(path).read
    else
      render text: "Sitemap not found.", status: :not_found
    end
  end

  def robots
  end

  private

  def set_locale
    if cookies['locale'] && I18n.available_locales.include?(cookies['locale'].to_sym)
      I18n.locale = cookies['locale'].to_sym
    else
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end

  def load_nav_items
    @nav_row = NavItem.orphans.order("position ASC").includes(:page, children: [:page])
  end

  def load_locale
    @locale = I18n.locale
  end
end
