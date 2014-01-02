class Report < ActiveRecord::Base
  attr_accessible :campaign_id, :user_id

  validates :campaign_id, :user_id, presence: true

  belongs_to :campaign
  belongs_to :user
end
