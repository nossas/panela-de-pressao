# coding: utf-8
class PokesController < InheritedResources::Base
  load_and_authorize_resource
  nested_belongs_to :campaign

  def create
    resource.user = current_user
    create! do |success, failure|
      success.html do
        redirect_to @campaign, :notice => "Seu email foi enviado aos alvos da campanha, é isso aí! Pressão neles!" if resource.email?
        redirect_to @campaign, :notice => "Uma nova mensagem foi postada no seu mural do Facebook, é isso aí! Pressão neles!" if resource.facebook?
      end
    end
  end
end
