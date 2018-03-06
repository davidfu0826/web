require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tlth
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom configuration
    config.x.aws_url = "https://#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com/".freeze
    config.x.sitemap_url = "#{config.x.aws_url}sitemaps/sitemap.xml.gz".freeze

    # Locales
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**',
                                                 '*.{rb,yml}').to_s]
    config.i18n.default_locale = :sv

    # Timezone
    config.time_zone = 'Stockholm'

    # Reverse proxy
    config.action_controller.forgery_protection_origin_check = false
  end
end
