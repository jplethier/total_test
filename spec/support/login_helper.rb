module LoginHelper
  include Warden::Test::Helpers

  def login_as_user(user = nil)
    user ||= FactoryGirl.create :user
    login_as(user, scope: :user)
  end

  RSpec.configure do |config|
    config.before(:each) do
      Warden.test_mode!
    end

    config.after(:each) do
      Warden.test_reset!
    end
  end
end
