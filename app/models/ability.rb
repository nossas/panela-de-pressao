class Ability
  include CanCan::Ability

  def initialize(user, options = nil)
    can :read, User
    can :read, Answer
    can :read, Influencer
    can :read, Campaign, Campaign.accepted do |campaign|
      campaign.accepted_at
    end
    can :read, Campaign, Campaign.unmoderated do |campaign|
      !campaign.preview_code.nil? and campaign.preview_code == options[:preview_code]    
    end

    can :read, Influencer
    can :create, Poke, :kind => "email"

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
