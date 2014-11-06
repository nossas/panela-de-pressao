class InfluencersController < InheritedResources::Base
  authorize_resource
  before_filter(only: [:create, :update]) { params[:influencer][:user_id] = current_user.id }
  before_filter :redirect_when_archived, only: :show
  respond_to :json

  def show
    @influencer = Influencer.find(params[:id])
    @campaigns = @influencer.campaigns.unarchived
  end

  def archive
    @influencer = Influencer.find(params[:id])
    @influencer.archive
    respond_with @influencer
  end

  def search
    respond_with PgSearch.multisearch(params[:q])
  end

  private
    def redirect_when_archived
      redirect_to influencers_path if resource.archived? && !can?(:edit, Influencer)
    end
end
