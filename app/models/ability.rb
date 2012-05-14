class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, Campaign, Campaign.accepted do |campaign|
      campaign.accepted_at
    end

    if user && user.admin?
      can :manage, :all
    elsif user
      can :create, Campaign
      can :create, Poke
      can :create, Organization
      can :update, Campaign, :user_id => user.id
      can :manage, Post, :campaign => {:user_id => user.id}
    end
  end
end
