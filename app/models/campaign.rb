class Campaign < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :accepted_at, :image, :image_cache, :category_id, :target_ids, :influencer_ids
  
  belongs_to :user
  belongs_to :organization
  belongs_to :category
  has_many :targets
  has_many :influencers, :through => :targets

  accepts_nested_attributes_for :targets
  accepts_nested_attributes_for :influencers

  default_scope order("accepted_at DESC")

  scope :accepted, where('accepted_at IS NOT NULL')

  mount_uploader :image, ImageUploader

  validates :name, :description, :user_id, :image, :category, :presence => true
end
