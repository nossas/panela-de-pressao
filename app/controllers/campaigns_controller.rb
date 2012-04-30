# coding: utf-8
class CampaignsController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:index, :create]
  before_filter :only => [:create] { params[:campaign][:user_id] = current_user.id }
  before_filter :only => [:show] { @poke = Poke.new }

  def create
    create! do |success, failure|
      success.html { redirect_to campaigns_path, :notice => "Aí! Recebemos a sua campanha. Em breve entraremos em contato para colocá-la no ar..." }
      failure.html { render :new }
    end
  end

  protected
  def collection
    @campaigns ||= end_of_association_chain.accepted
  end
end
