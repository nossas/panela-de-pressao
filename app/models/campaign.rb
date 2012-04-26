class Campaign < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :accepted_at, :image, :image_cache, :category_id
  
  belongs_to :user
  belongs_to :organization
  belongs_to :category

  default_scope order("accepted_at DESC")

  scope :accepted, where('accepted_at IS NOT NULL')

  mount_uploader :image, ImageUploader

  validates :name, :description, :user_id, :image, :category_id, :presence => true
end
