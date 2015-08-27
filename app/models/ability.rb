class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin?
      can :manage, :all
    else
      can [:update, :show], User, id: user.id  
      can [:read, :update, :show], Exam, user_id: user.id 
      can [:create,:update, :show], Exam
    end
  end
end
