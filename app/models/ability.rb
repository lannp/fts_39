class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    end
    if user
      can :create, :exam
      can [:read, :update], :exam, user_id: user.id
    end
  end
end
