# coding: utf-8
class UpdatesController < InheritedResources::Base
  layout false
  belongs_to :campaign
  before_filter(only: ["create"]) { params[:update][:user_id] = current_user.id }

  def create
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
