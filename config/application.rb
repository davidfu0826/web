require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Tlth
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths << Rails.root.join('lib')

    config.active_record.raise_in_transactional_callbacks = true

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Stockholm'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[File.join(Rails.root.to_s, 'config', 'locales', '**', '*.{rb,yml}')]
    config.i18n.default_locale = :sv

    #Automatically embed CSRF token in AJAX forms
    config.action_view.embed_authenticity_token_in_remote_forms = true

    # Opt into transactional callbacks
    config.active_record.raise_in_transactional_callbacks = true

    config.generators do |g|
      g.controller_specs false
      g.view_specs false
      g.helper_specs false
      g.model_specs false
      g.stylesheets false
      g.javascripts false
      g.helper false
    end
  end
end
