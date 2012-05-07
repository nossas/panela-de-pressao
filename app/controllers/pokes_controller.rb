# coding: utf-8
class PokesController < InheritedResources::Base
  load_and_authorize_resource :only => [:create]
  belongs_to :campaign

  prepend_before_filter(:only => [:create]) do 
    session[:poke] = params[:poke].merge(:campaign_id => params[:campaign_id]) if current_user.nil? && params[:poke]
  end

  before_filter do
    params[:poke] ||= {}
    params[:poke][:user_id] = current_user.id
  end
  
  def create_from_session
    params[:poke] = session.delete(:poke)
    create
  end

  def create
    create! do |success, failure|
      success.html { redirect_to @campaign, :notice => "Seu email foi enviado aos alvos da campanha, é isso aí! Pressão neles!" }
    end
  end
end
