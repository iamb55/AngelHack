class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Conversation, :mentor_id => user.id if user.user_type == "mentor" 
    can :manage, Conversation, :mentee_id => user.id if user.user_type == "mentee" 
  end
end
