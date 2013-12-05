# coding: utf-8
class PokesController < InheritedResources::Base
  load_and_authorize_resource
  belongs_to :campaign

  respond_to :json, only: :index

  prepend_before_filter(:only => [:create], :if => Proc.new { request.post? }) do 
    session[:poke] = params[:poke].merge(:campaign_id => params[:campaign_id])
  end

  before_filter :only => [:create] do
    require_facebook_auth if session[:poke][:kind] == "facebook" && params[:user_id].nil?
    require_twitter_auth if session[:poke][:kind] == "twitter" && params[:user_id].nil?
  end

  def create
    user = current_user || User.find_by_id(params[:user_id]) || User.find_or_create_by_email(params[:email], :first_name => params[:name], :last_name => params[:last_name])
    user.update_attribute(:phone, params[:phone]) if params[:phone]

    @poke = Poke.new session.delete(:poke).merge(:user_id => user.id)
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
    @pokes = @campaign.pokes.includes(:user)
    index!
  end
end
