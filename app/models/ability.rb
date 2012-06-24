class Ability
  include CanCan::Ability

  def initialize(user)
    if user.user_type == "mentor"
      can :manage, Conversation, :mentor_id => user.id 
      can :manage, Message, :conversation => { :mentor_id => user.id }
      can :manage, Mentor, :id => user.id
    elsif user.user_type == "mentee"
      can :manage, Conversation, :mentee_id => user.id 
      can :manage, Message, :conversation => { :mentee_id => user.id }
      can :manage, Mentee, :id => user.id
    else
      redirect_to '/'
    end
  end
end
