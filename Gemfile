source 'https://rubygems.org'

ruby '2.2.0'

# Core
gem 'rails', '4.2.0'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'autoprefixer-rails'
gem 'rack-cache', :require => 'rack/cache' #Caching images
gem 'devise'
gem 'cancancan', '~> 1.8'
gem 'turbolinks'

# Assets
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'bootstrap_form'
gem 'bootstrap3-datetimepicker-rails', '~> 3.0.0.2'
gem 'momentjs-rails', '>= 2.5.0' #Required for datetimepicker
gem 'rails_bootstrap_navbar'
gem 'font-awesome-rails' # Used by summernote
gem 'select2-rails'
gem 'auto_html'
gem 'jquery-minicolors-rails'
gem 'http_accept_language' #Auto set locale
gem 'traco' #Localization
gem 'nested_form'
gem 'icalendar' # Export i ics calendar files
gem 'acts_as_list'
gem 'dragonfly', "~>1.0.5" #Image Uploading
gem 'dragonfly-s3_data_store' # Store images on s3
gem 'twitter'
gem 'dynamic_sitemaps'
gem 'whenever', :require => false #Automatically generate sitemaps
gem 'rails-settings-cached', '0.4.1'
gem 'remotipart', '~> 1.2'
gem 'kaminari' # Pagination
gem 'kaminari-bootstrap', '~> 3.0.1'
gem 'codemirror-rails' # Used by summernote for displaying html
gem 'fuzzily' #Fuzzy string search
gem 'dalli' # Memcaching
gem 'newrelic_rpm'

group :development do
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller' #Used by better errors to provide REPL
  gem 'meta_request' # Used by chrome plugin railspanel to show request info
  gem 'faker'
  gem 'bullet' # Display N+1 problems
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'rails_stdout_logging'
end
