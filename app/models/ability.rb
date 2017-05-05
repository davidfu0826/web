class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :read, [Document, Event, Post]
    can :archive, Post
    can :show, [Image, Page, Upload]

    if user.admin?
      can :manage, :all
    elsif user.editor?
      can :manage, [ContactForm, Document, Image, Page, Post, Upload, Tag]
    elsif user.events?
      can :manage, [Event, Image]
    end

    return unless User.exists?(user.id)
    can :read, Upload
    can [:update, :destroy], user
    can :manage, user.contact_forms
    can [:update, :add_user, :remove_user], user.pages
  end
end
