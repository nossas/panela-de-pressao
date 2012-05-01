# coding: utf-8
class PokesController < InheritedResources::Base
  load_and_authorize_resource
  nested_belongs_to :campaign

  def create
    resource.user = current_user
    create! do |success, failure|
      success.html { redirect_to @campaign, :notice => "Pressão neles!" }
    end
  end
end
