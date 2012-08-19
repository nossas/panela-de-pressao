# coding: utf-8
class PokesController < InheritedResources::Base
  load_and_authorize_resource :only => [:create]
  belongs_to :campaign

  prepend_before_filter(:only => [:create], :if => Proc.new { request.post? }) do 
    session[:poke] = params[:poke].merge(:campaign_id => params[:campaign_id])
  end

  before_filter :only => [:create] do
    require_facebook_auth if session[:poke][:kind] == "facebook"
    require_twitter_auth if session[:poke][:kind] == "twitter"
  end

  def create
    @poke = Poke.new session.delete(:poke).merge(:user_id => current_user.id)
    create! do |success, failure|
      success.html do
        flash[:facebook_poke_notice] = "Muito bom! Você pressionou pelo Facebook." if resource.kind == "facebook"
        flash[:twitter_poke_notice] = "Muito bom! Você pressionou pelo Twitter." if resource.kind == "twitter"
        redirect_to campaign_path(@campaign)
      end
      failure.html { redirect_to campaign_url(@campaign) }
    end
  end
end
