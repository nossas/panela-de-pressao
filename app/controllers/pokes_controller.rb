# coding: utf-8
class PokesController < InheritedResources::Base
  load_and_authorize_resource
  belongs_to :campaign

  prepend_before_filter(:only => [:create]) do 
    session[:poke] = params[:poke].merge(:campaign_id => params[:campaign_id]) if current_user.nil? && params[:poke]
  end

  def create
    resource.user = current_user
    create! do |success, failure|
      success.html { redirect_to @campaign, :notice => "Seu email foi enviado aos alvos da campanha, é isso aí! Pressão neles!" }
    end
  end
end
