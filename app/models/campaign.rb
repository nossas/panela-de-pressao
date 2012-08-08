class Campaign < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :accepted_at, :image, 
    :image_cache, :category_id, :target_ids, :influencer_ids, :short_url, 
    :email_text, :facebook_text, :twitter_text, :map_embed, :map_description, 
    :pokers_email, :finished_at
  
  belongs_to :user
  belongs_to :category
  has_many :targets
  has_many :influencers, :through => :targets
  has_many :pokes
  has_many :posts
  has_many :answers
  before_save { CampaignMailer.campaign_accepted(self).deliver if accepted_at_changed? && persisted? }
  after_create { CampaignMailer.campaign_awaiting_moderation(self).deliver }
  after_create { CampaignMailer.we_received_your_campaign(self).deliver }

  accepts_nested_attributes_for :targets
  accepts_nested_attributes_for :influencers

  default_scope order("accepted_at DESC")

  scope :accepted, where('accepted_at IS NOT NULL')
  scope :unmoderated, where('accepted_at IS NULL')

  mount_uploader :image, ImageUploader

  validates :name, :description, :user_id, :image, :category, :email_text, :facebook_text, :twitter_text, :presence => true  
  validates_length_of :twitter_text, :maximum => 100

  validates_format_of :map_embed, with: /\A<iframe(.*)src=\"http(s)?:\/\/(maps.google.com\/maps)|(google.com\/maps).*\Z/i, allow_nil: true, allow_blank: true

  def accepted?
    !accepted_at.nil?
  end

  def influencers
    Influencer.joins(:targets).where(['targets.campaign_id = ?', self.id])
  end

  def not_empty_influencer(opt = :email)
    self.influencers.select { |a| a.send(opt.to_s) != "" }    
  end

  def pokes
    Poke.where(['pokes.campaign_id = ?', self.id])
  end

  def pokes_by(opt = :email)
    self.pokes.select { |a| a.kind == opt.to_s }
  end

  def pokers
    User.joins(:pokes).
      select("users.*, (
             SELECT COUNT(p.*) FROM pokes p 
             WHERE p.user_id = users.id
             AND p.campaign_id = #{self.id}
            ) as pokes_count").
      where(["pokes.campaign_id = ?", self.id]).uniq
  end 

  def more_active_pokers 
    pokers.sort { |a,b| b.pokes_count.to_i <=> a.pokes_count.to_i  } 
  end

  def finished?
    !self.finished_at.nil?
  end
end
