class Report < ActiveRecord::Base
  attr_accessible :campaign_id, :user_id

  belongs_to :campaign
  belongs_to :user
end
