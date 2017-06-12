class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :load_nav_items_and_locale

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  before_action :prepare_meta_tags, if: 'request.get?'

  def prepare_meta_tags(options = {})
    site_name   = I18n.t('global.title')
    description = I18n.t('global.description')
    image       = options[:image] || view_context.image_url('blue_mark.svg')
    current_url = request.url

    defaults = {
      site:        site_name,
      image:       image,
      description: description,
      keywords:    I18n.t('global.keywords'),
      twitter: {
        site_name: site_name,
        site: '@Teknologkaren',
        card: 'summary',
        description: description,
        image: image
      },
      og: {
        url: current_url,
        site_name: site_name,
        image: image,
        description: description,
        type: 'website'
      }
    }

    options.reverse_merge!(defaults)
    set_meta_tags options
  end

  private

  def set_locale
    if cookies['locale'] && I18n.available_locales.include?(cookies['locale'].to_sym)
      I18n.locale = cookies['locale'].to_sym
    else
      I18n.locale = I18n.default_locale
    end
  end

  def load_nav_items_and_locale
    @navbar_items = NavItem.orphans.order(position: :asc)
                           .includes(:page, children: :page)
    @locale = I18n.locale
  end
end
