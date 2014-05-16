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
      user = current_user || User.find_by_id(params[:user_id]) || User.find_by_email(params[:email]) || User.create(params)
      user.update_ip(params[:ip])
      user.update_attribute(:phone, params[:phone]) if params[:phone]
      @poke = Poke.new session.delete(:poke).merge(:user_id => user.id)
    rescue Exception => e
      Rails.logger.error e
    end

    create! do |success, failure|
      success.html do
        if @poke.phone?
          flash[:poke_phone_notice] = true
        else
          flash[:poke_notice] = true
        end
        redirect_to campaign_path(@campaign)
      end

      failure.html do
        redirect_to @campaign, :alert => "Não foi possível realizar a pressão :("
      end
    end
  end

  def index
    @pokes = @campaign.pokes.includes(:user).order("created_at DESC")

    @pokes = @pokes.where('created_at >= :from', from: format_date(params[:from])) unless params[:from].blank?
    @pokes = @pokes.where('created_at <= :until', until: format_date(params[:until])) unless params[:until].blank?

    index!
  end

  private

  def format_date string
    DateTime.strptime(string, '%Y-%m-%d-%H-%M-%S') if string
  end
end
