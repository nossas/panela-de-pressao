# coding: utf-8
class PokesController < InheritedResources::Base
  load_and_authorize_resource
  belongs_to :campaign

  respond_to :json, only: :index

  prepend_before_filter(:only => [:create], :if => Proc.new { request.post? }) do
    session[:poke] = params[:poke].merge(:campaign_id => params[:campaign_id])
    session[:first_name] = params[:first_name]
    session[:last_name] = params[:last_name]
    session[:email] = params[:email]
  end

  before_filter :only => [:create] do
    if session[:poke]
      require_facebook_auth if session[:poke][:kind] == "facebook" && params[:user_id].nil?
      require_twitter_auth if session[:poke][:kind] == "twitter" && (params[:user_id].nil? and not current_user.try(:twitter_authorization))
    end
  end

  def create
    begin
      params[:ip] = request.remote_ip
      params[:organization_id] = @campaign.organization_id
      params[:password] = SecureRandom.hex

      user = current_user ||
        User.find_by_id(params[:user_id]) ||
        User.find_by_email(params[:email].downcase) ||
        User.find(User.create(params).id)

      user.update_ip(params[:ip])
      user.update_attribute(:phone, params[:phone]) if params[:phone]

      poke_params = session[:poke] || params[:poke] || {}
      @poke = Poke.new poke_params
      @poke.user = user
      session[:poke] = nil
    rescue Exception => e
      Appsignal.add_exception e
      Rails.logger.error e
    end

    create! do |success, failure|
      success.html do
        if @poke.phone?
          flash[:poke_phone_notice] = true
        else
          flash[:poke_notice] = true
        end

        if current_user || flash[:poke_phone_notice]
          redirect_to campaign_path(@campaign, success: true)
        else
          redirect_to campaign_path(@campaign, success: true, anchor: 'create_your_profile')
        end
      end

      failure.html do
        @answer = Answer.new
        @featured_update = Update.find_by_id(params[:update_id])
        @last_update = @campaign.updates.order("created_at DESC").first
        @campaign_users = CampaignOwner.where(campaign_id: @campaign.id).map{|co| co.user}
        @campaign_pokes = Poke.where(campaign_id: @campaign.id).includes(:user).limit(5)
        render "campaigns/show"
      end
    end
  end

  def index
    @pokes = @campaign.pokes.includes(:user).order("created_at DESC")

    @pokes = @pokes.where('created_at >= :from', from: format_date(params[:from])) unless params[:from].blank?
    @pokes = @pokes.where('created_at <= :until', until: format_date(params[:until])) unless params[:until].blank?

    render json: @pokes
  end

  private

  def format_date string
    DateTime.strptime(string, '%Y-%m-%d-%H-%M-%S') if string
  end
end
