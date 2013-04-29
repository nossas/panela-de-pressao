class InfluencersController < InheritedResources::Base
  authorize_resource
  before_filter(only: [:create, :update]) { params[:influencer][:user_id] = current_user.id }
end
