#require 'SessionsHelper'

class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    #binding.pry
    if user.role == nil || user.role == "guest"
        can [:read, :published, :drafts], Breve
        can [:read], Version
        can :create, User
    elsif user.role == "standard"
        can [:read, :published, :drafts, :create, :update], Breve
        can [:read, :revert], Version
        can :read, User
    elsif user.role == "editor"
        can [:read, :published, :drafts, :create, :update, :destroy], Breve
        can [:read, :revert], Version
        can :read, User
    elsif user.role == "admin"
        can :manage, Breve
        can [:read, :revert], Version
        can :manage, User
    end
    #binding.pry

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
