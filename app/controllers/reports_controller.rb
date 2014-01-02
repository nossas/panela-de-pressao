class ReportsController < InheritedResources::Base
  def create
    @campaign = Campaign.find(params[:campaign_id])
    Report.create! user_id: current_user.id, campaign_id: @campaign.id
    redirect_to campaign_path(@campaign)
  end
end
