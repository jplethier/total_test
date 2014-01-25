module ControllerHelpers
  def sign_in(user = stub(:user).as_null_object)
    if user.nil?
      request.env['warden'].stub(:authenticate!).and_throw(:warden, { scope: :user })
      controller.stub current_user: nil
    else
      request.env['warden'].stub authenticate!: user
      controller.stub current_user: user
    end
  end

  # def cancan_setup
  #   @ability = Object.new
  #   @ability.extend(CanCan::Ability)
  #   @controller.stub(current_ability: @ability)
  # end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers,  type: :controller
  config.include ControllerHelpers,    type: :controller

  # config.before(:each, type: :controller) { cancan_setup }
end
