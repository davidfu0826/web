source 'https://rubygems.org'

ruby '2.4.1'

gem 'rails', '4.2.8'

# Core
gem 'autoprefixer-rails'
gem 'cancancan', '~> 1.8'
gem 'coffee-rails', '~> 4.0.0'
gem 'devise'
gem 'jquery-rails'
gem 'pg'
gem 'rack-cache', require: 'rack/cache' # Caching images
gem 'turbolinks'
gem 'uglifier', '>= 1.3.0'

# Assets
gem 'acts_as_list'
gem 'bootstrap-sass'
gem 'bootstrap3-datetimepicker-rails'
gem 'bootstrap_form'
gem 'carrierwave' # File uploads
gem 'carrierwave-aws'
gem 'codemirror-rails' # Used by summernote for displaying html
gem 'dragonfly' # Image Uploading
gem 'dragonfly-s3_data_store' # Store images on s3
gem 'font-awesome-rails' # Used by summernote
gem 'font-awesome-sass'
gem 'fuzzily' # Fuzzy string search
gem 'http_accept_language' # Auto set locale
gem 'icalendar' # Export i ics calendar files
gem 'kaminari' # Pagination
gem 'kaminari-bootstrap', '~> 3.0.1'
gem 'meta-tags'
gem 'mini_magick'
gem 'momentjs-rails', '>= 2.5.0' # Required for datetimepicker
gem 'nested_form'
gem 'rails-settings-cached', '0.4.1'
gem 'rails_bootstrap_navbar'
gem 'remotipart', '~> 1.2'
gem 'rollbar'
gem 'sass-rails'
gem 'select2-rails'
gem 'sitemap_generator'
gem 'traco' # Localization
gem 'twitter'
gem 'zeroclipboard-rails'

group :development do
  gem 'awesome_print' # Better printing in console
  gem 'better_errors'
  gem 'binding_of_caller' # Used by better errors to provide REPL
  gem 'bullet' # Display N+1 problems
  gem 'web-console'
end

group :development, :test do
  gem 'capybara'
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'poltergeist'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'faker'
  gem 'meta_request' # Used by chrome plugin railspanel to show request info
  gem 'shoulda-matchers', require: false
  gem 'spring'
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'rails_stdout_logging'
end
