class Campaign < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  
  belongs_to :user
  belongs_to :organization

  default_scope order("accepted_at DESC")

  scope :accepted, where('accepted_at IS NOT NULL')

  mount_uploader :image, ImageUploader
end
