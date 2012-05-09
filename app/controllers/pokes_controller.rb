# coding: utf-8
class PokesController < InheritedResources::Base
  load_and_authorize_resource :only => [:create]
  belongs_to :campaign

  prepend_before_filter(:only => [:create]) do 
    session[:poke] = params[:poke].merge(:campaign_id => params[:campaign_id]) if current_user.nil? && params[:poke]
  end

  def create_from_session
    params[:poke] = session.delete(:poke)
    create
  end

  def create
    @poke = Poke.new params[:poke].merge(:user_id => current_user.id, :campaign_id => params[:campaign_id])
    create! do |success, failure|
      success.html do
        redirect_to @campaign, :notice => "Seu email foi enviado aos alvos da campanha, é isso aí! Pressão neles!" if resource.email?
        redirect_to @campaign, :notice => "Uma nova mensagem foi postada no seu mural do Facebook, é isso aí! Pressão neles!" if resource.facebook?
      end
    end
  end
end
