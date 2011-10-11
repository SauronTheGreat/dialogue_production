# To change this template, choose Tools | Templates
# and open the template in the editor.

class Ability
  include CanCan::Ability

  def initialize(user)
    #    user ||= User.new # guest user

    if user.admin
      can :manage, :all
      #    elsif user.educator
      #      can :read, :all
    elsif user.educator
      can :manage, :all
    else
      can :manage, :all
    end

    if user.admin
      can :see_timestamps, User
    else
      can :see_timestamps, User, :id => user.id
    end
  end

end