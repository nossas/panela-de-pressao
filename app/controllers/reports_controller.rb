# coding: utf-8

class ReportsController < InheritedResources::Base
  def create
    @campaign = Campaign.find(params[:campaign_id])
    Report.create! user_id: current_user.id, campaign_id: @campaign.id
    redirect_to campaign_path(@campaign), notice: "Nossa equipe já foi notificada sobre a sua denúncia, obrigado!"
  end
end
