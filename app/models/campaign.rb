class Campaign < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :accepted_at, :image, :image_cache, :category_id, :target_ids, :influencer_ids, :short_url, :organization_ids, :email_text, :facebook_text, :twitter_text
  
  belongs_to :user
  belongs_to :category
  has_many :targets
  has_many :influencers, :through => :targets
  has_many :pokes
  has_many :posts
  has_and_belongs_to_many :organizations
  before_save { CampaignMailer.campaign_accepted(self).deliver if accepted_at_changed? && persisted? }

  accepts_nested_attributes_for :targets
  accepts_nested_attributes_for :influencers
  accepts_nested_attributes_for :organizations

  default_scope order("accepted_at DESC")

  scope :accepted, where('accepted_at IS NOT NULL')
  scope :unmoderated, where('accepted_at IS NULL')

  mount_uploader :image, ImageUploader

  validates :name, :description, :user_id, :image, :category, :email_text, :facebook_text, :twitter_text, :presence => true  
  validates_length_of :twitter_text, :maximum => 100

  def accepted?
    !accepted_at.nil?
  end

  def pokers
    User.joins(:pokes).where("pokes.campaign_id = #{id}").uniq
  end 

  def more_active_pokers 
    User.find_by_sql("                 
      SELECT DISTINCT u.*, 
        (SELECT COUNT(*) FROM pokes WHERE pokes.user_id = u.id) AS pokes_counter
      FROM users u 
      INNER JOIN pokes ON pokes.campaign_id = #{self.id}                 
    ")
  end
end
