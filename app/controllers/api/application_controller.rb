class Api::ApplicationController < ActionController::Base
  doorkeeper_for :all

  def current_resource_owner
    @user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
