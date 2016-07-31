RSpec.configure do |config|
  config.before(:suite) do
    Dragonfly.app.use_datastore(:memory)
  end
end
