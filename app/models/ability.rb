require 'pry'

class Ability
  include CanCan::Ability

  def initialize(user)
    binding.pry
    if user.nil?
      return
    elsif user.user_type == 'mentor'
      can :manage, Conversation
      can :manage, Message
      can :manage, Mentor
    elsif user.user_type == 'mentee'
      can :manage, Conversation
      can :manage, Message
      can :manage, Mentee
    end
  end
end
