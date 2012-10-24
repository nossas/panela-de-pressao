class InfluencersController < InheritedResources::Base
  load_and_authorize_resource

	def update
		@influencer.user_id = current_user.id
		update!
	end

	def create
		@influencer.user_id = current_user.id
		create!
	end
end
