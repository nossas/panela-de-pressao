class Campaign < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :accepted_at, :image, :image_cache, :category_id, :target_ids, :influencer_ids, :short_url, :partners_attributes
  
  belongs_to :user
  belongs_to :organization
  belongs_to :category
  has_many :targets
  has_many :influencers, :through => :targets
  has_many :pokes
  has_many :posts
  has_many :partners, class_name: "CampaignPartner"
  before_save { CampaignMailer.campaign_accepted(self).deliver if accepted_at_changed? && persisted? }

  accepts_nested_attributes_for :targets
  accepts_nested_attributes_for :influencers
  accepts_nested_attributes_for :partners

  default_scope order("accepted_at DESC")

  scope :accepted, where('accepted_at IS NOT NULL')
  scope :unmoderated, where('accepted_at IS NULL')

  mount_uploader :image, ImageUploader

  validates :name, :description, :user_id, :image, :partners, :category, :presence => true

  def accepted?
    !accepted_at.nil?
  end

  def pokers
    pokes.map{|p| p.user}.uniq
  end
end
