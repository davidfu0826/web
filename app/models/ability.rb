class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, :all
    cannot :read, User
    can :archive, Post
    if user.admin?
      can :manage, :all
    elsif user.editor?
      can :manage, [Post]
    elsif user.events?
      can :manage, [Event, EventGroup]
    end

    if User.exists?(user)
      can [:update, :destroy], user
      can :manage, user.contact_forms
      can :create, ContactForm
      can [:update, :add_user, :remove_user], user.pages
    end
  end
end
