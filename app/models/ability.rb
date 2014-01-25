class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    unless user.guest?
      can :manage, Task, user_id: user.id
    end
  end
end
