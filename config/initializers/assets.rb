module Tlth
  class Application < Rails::Application
    config.assets.paths << "#{Rails}/vendor/assets/fonts"
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
  end
end
