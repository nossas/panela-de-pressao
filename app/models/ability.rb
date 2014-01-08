class Ability
  include CanCan::Ability

  def initialize(user, request)
    can :read, User
    can :read, Answer
    can :manage, Poke
    can :read, Campaign

    if user && user.admin?
      can :manage, :all
    elsif user
      can :create, Campaign
      can :update, Campaign, user_id: user.id
      can :read, Campaign, user_id: user.id
      can :update, User, id: user.id
      can :create, Report
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
