class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, User
    can :read, Influencer
    can :read, Campaign, Campaign.accepted do |campaign|
      campaign.accepted_at
    end
    can :read, Influencer

    if user && user.admin?
      can :manage, :all
    elsif user
      can :create, Campaign
      can :create, Poke
      can :update, Campaign, :user_id => user.id
      can :update, User, id: user.id
    end
  end
end
