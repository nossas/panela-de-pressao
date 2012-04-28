class Target < ActiveRecord::Base
  attr_accessible :campaign_id, :influencer_id
  belongs_to :influencer
  belongs_to :campaign
end
