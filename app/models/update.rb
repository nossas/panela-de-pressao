class Update < ActiveRecord::Base
  attr_accessible :body, :campaign_id, :image, :title
  belongs_to :campaign
  validates :body, :campaign_id, :image, :title, presence: true
  mount_uploader :image, UpdateImageUploader
end
