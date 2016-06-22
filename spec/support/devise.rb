RSpec.configure do |config|	
	include Warden::Test::Helpers
	config.include Devise::TestHelpers, type: :routing
  config.include Devise::TestHelpers, type: :controller
  config.extend ControllerMacros, :type => :controller
  
  config.before :suite do
    Warden.test_mode!
  end


  config.after :each do
    Warden.test_reset!
  end
end