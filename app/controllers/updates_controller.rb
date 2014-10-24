# coding: utf-8
class UpdatesController < InheritedResources::Base
  load_and_authorize_resource
  layout false
  belongs_to :campaign

  def create
    @update = Update.new(params[:update].merge(user_id: current_user.id, campaign_id: parent.id))    
    create! do |format|
      format.html { redirect_to updates_campaign_path(@campaign, anchor: "update_#{@update.id}") }
    end
  end

  def update
    update! do |format|
      format.html { redirect_to updates_campaign_path(@campaign, anchor: "update_#{@update.id}") }
    end
  end
  
  def destroy
    destroy!(notice: "Atualização removida com sucesso")
  end
end
