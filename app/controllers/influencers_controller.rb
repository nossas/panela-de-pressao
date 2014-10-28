class InfluencersController < InheritedResources::Base
  authorize_resource
  before_filter(only: [:create, :update]) { params[:influencer][:user_id] = current_user.id }
  before_filter :redirect_when_archived, only: :show

  def show
    @influencer = Influencer.find(params[:id])
    @campaigns = @influencer.campaigns.unarchived
  end

  private
    def redirect_when_archived
      redirect_to influencers_path if resource.archived? && !can?(:edit, Influencer)
    end
end
