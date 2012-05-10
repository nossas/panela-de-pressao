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
        redirect_to @campaign, :notice => "Seu email foi enviado aos alvos da campanha, é isso aí! Pressão neles!" if resource.email?
        redirect_to @campaign, :notice => "Uma nova mensagem foi postada no seu mural do Facebook, é isso aí! Pressão neles!" if resource.facebook?
        redirect_to @campaign, :notice => "Mais um tweet para a campanha, é isso aí! Pressão neles!" if resource.twitter?
      end
    end
  end
end
