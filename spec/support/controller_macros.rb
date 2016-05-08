module ControllerMacros
  RSpec.configure do |config|
    config.before :each, type: :controller do
      @ability = Object.new
      @ability.extend(CanCan::Ability)
      allow(controller).to receive(:current_ability).and_return(@ability)
    end
  end

  def allow_user_to(*args)
    before(:each) do
      @ability.can(*args)
    end
  end
end
