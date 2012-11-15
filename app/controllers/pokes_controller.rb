# coding: utf-8
class PokesController < InheritedResources::Base
  load_and_authorize_resource
  belongs_to :campaign

  prepend_before_filter(:only => [:create], :if => Proc.new { request.post? }) do 
    session[:poke] = params[:poke].merge(:campaign_id => params[:campaign_id])
  end

  before_filter :only => [:create] do
    require_facebook_auth if session[:poke][:kind] == "facebook"
    require_twitter_auth if session[:poke][:kind] == "twitter"
  end

  def create
    user = current_user || User.find_or_create_by_email(params[:email], :name => params[:name])
    @poke = Poke.new session.delete(:poke).merge(:user_id => user.id)
    create! do |success, failure|
      success.html do
        flash[:poke_notice] = true
        redirect_to campaign_path(@campaign)
      end
      failure.html do
        redirect_to @campaign, :alert => "Não foi possível realizar a pressão :("
      end
    end
  end
end
