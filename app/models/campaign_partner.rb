class CampaignPartner < ActiveRecord::Base
  attr_accessible :campaign_id, :organization_id, :user_id
  belongs_to :campaign
  belongs_to :organization
  belongs_to :user
end
