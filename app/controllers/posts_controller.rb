class PostsController < ApplicationController
  load_and_authorize_resource
  inherit_resources
  actions :create, :index, :destroy
  belongs_to :campaign

  def create
    create! do |format|
      format.html{ return redirect_to campaign_posts_path(:campaign_id => @campaign.id) }
    end
  end

  def index
    index! do
      return render :layout => false
    end
  end

  def destroy
    destroy! do |format|
      format.html{ return redirect_to campaign_posts_path(:campaign_id => @campaign.id) }
    end
  end
end
