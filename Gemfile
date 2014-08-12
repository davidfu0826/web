source 'https://rubygems.org'

# Core
gem 'rails', '4.1.1'
gem 'pg'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'autoprefixer-rails'
gem 'rack-cache', :require => 'rack/cache' #Caching images
gem 'devise'
gem 'cancancan', '~> 1.8'

# Assets
gem 'sass-rails', '~> 4.0.3'
gem 'bootstrap-sass', '~> 3.2.0'
gem 'bootstrap_form'
gem 'bootstrap3-datetimepicker-rails', '~> 3.0.0.2'
gem 'pagedown-bootstrap-rails'
gem 'rails_bootstrap_navbar'
gem 'font-awesome-rails' # Used by pagedown-bootstrap
gem 'momentjs-rails', '>= 2.5.0' #Required for datetimepicker
gem 'select2-rails'
gem 'auto_html'
gem 'redcarpet'

# Other
gem 'http_accept_language' #Auto set locale
gem 'traco' #Localization
gem 'nested_form'
gem 'icalendar'
gem 'acts_as_list'
gem 'dragonfly', "~>1.0.5" #Image Uploading
gem 'will_paginate-bootstrap'
gem 'twitter'
gem 'dynamic_sitemaps'
gem 'whenever', :require => false #Automatically generate sitemaps

group :development do
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'faker'
end

group :development, :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'spring-commands-rspec'
  gem 'capybara'
end

group :production do
  gem 'puma'
  gem 'rails_12factor'
  gem 'rails_stdout_logging'
end
