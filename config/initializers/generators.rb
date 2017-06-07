# Do not use all generators by default
Rails.application.config.generators.each do |g|
  g.controller_specs false
  g.view_specs false
  g.helper_specs false
  g.model_specs false
  g.stylesheets false
  g.javascripts false
  g.helper false
end
