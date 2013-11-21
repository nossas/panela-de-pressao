class Ability
  include CanCan::Ability

  def initialize(user, request)
    can :read, User
    can :read, Answer
    can :read, Poke
    can :read, Campaign do |campaign|
      campaign.accepted_at
    end
    can :read, Campaign do |campaign|
      !campaign.preview_code.nil? and campaign.preview_code == request.params[:preview_code]    
    end
    can :create, Poke

    if user && user.admin?
      can :manage, :all
    elsif user
      can :create, Campaign
      can :update, Campaign, user_id: user.id
      can :read, Campaign, user_id: user.id
      can :update, User, id: user.id
    end

    if request.params[:format] == "json"
      if request.params[:token] == ENV['API_TOKEN']
        can :index, Poke
        can :index, Campaign
      else
        cannot :index, Campaign
        cannot :index, Poke
      end
    end
  end
end
