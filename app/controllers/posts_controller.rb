class PostsController < ApplicationController
  inherit_resources
  actions :create, :index
  belongs_to :campaign

  def create
    create! do |format|
      format.html{ return redirect_to campaign_posts_path }
    end
  end
end
