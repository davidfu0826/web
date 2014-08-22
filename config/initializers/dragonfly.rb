require 'dragonfly'
require 'dragonfly/s3_data_store'

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  url_format "/media/:job/:name"

  if !Rails.env.production?
    protect_from_dos_attacks true
    secret Rails.application.secrets.dragonfly_dos_protection

    datastore :s3,
      bucket_name: Rails.application.secrets.dragonfly_bucket,
      access_key_id: Rails.application.secrets.dragonfly_access_key_id,
      secret_access_key: Rails.application.secrets.dragonfly_secret_access_key,
      region: 'eu-west-1'
  else
    datastore :file,
      root_path: Rails.root.join('public/system/dragonfly', Rails.env),
      server_root: Rails.root.join('public')
  end
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend Dragonfly::Model
  ActiveRecord::Base.extend Dragonfly::Model::Validations
end
