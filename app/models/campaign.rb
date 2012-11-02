class Campaign < ActiveRecord::Base
  include AutoHtml
  attr_accessible :description, :name, :user_id, :user_ids, :accepted_at, :image, 
    :image_cache, :category_id, :target_ids, :influencer_ids, :short_url, 
    :email_text, :facebook_text, :twitter_text, :map_embed, :map_description, 
    :pokers_email, :finished_at, :succeed, :video_url

  has_and_belongs_to_many :users
  belongs_to :user
  belongs_to :category
  has_many :targets
  has_many :influencers, :through => :targets
  has_many :pokes
  has_many :posts
  has_many :answers
  before_save { self.description_html = convert_html(description) }
  before_save { CampaignMailer.delay.campaign_accepted(self) if accepted_at_changed? && persisted? }
  after_create { self.delay.generate_short_url! }
  after_create { CampaignMailer.delay.campaign_awaiting_moderation(self) }
  after_create { CampaignMailer.delay.we_received_your_campaign(self) }

  accepts_nested_attributes_for :targets
  accepts_nested_attributes_for :influencers

  default_scope order("accepted_at DESC")

  scope :accepted, where('accepted_at IS NOT NULL')
  scope :unmoderated, where(accepted_at: nil)
  scope :featured, where('featured_at IS NOT NULL').reorder('finished_at DESC')
  scope :unfinished, where('finished_at IS NULL')

  mount_uploader :image, ImageUploader

  validates :name, :user_id, :description, :image, :category, :email_text, :facebook_text, :twitter_text, :presence => true  
  validates_format_of :video_url, with: /\A(?:http:\/\/)?(?:www\.)?(youtube\.com\/watch\?v=([a-zA-Z0-9_-]*))|(?:www\.)?vimeo\.com\/(\d+)\Z/, allow_blank: true
  validates_length_of :twitter_text, :maximum => 100
  validates_format_of :map_embed, with: /\A<iframe(.*)src=\"http(s)?:\/\/(maps.google.com\/maps)|(google.com\/maps).*\Z/i, allow_nil: true, allow_blank: true
  validate :owner_have_mobile_phone

  def video
    video = VideoInfo.new(self.video_url)
    return video.embed_code if video.valid?
  end

  def convert_html(text) 
    auto_html text do
      image
      youtube(width: "100%", height: 300)
      redcarpet :target => :_blank      
    end
  end

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
    self.pokes.where(:kind => opt.to_s)
  end

  def pokers
    User
    .joins(:pokes)
    .where(["pokes.campaign_id = ?", self.id]).order('created_at DESC').uniq
  end 

  def more_active_pokers 
    pokers.sort { |a,b| b.pokes_count.to_i <=> a.pokes_count.to_i  } 
  end

  def finished?
    !self.finished_at.nil?
  end

  def targets_with_facebook
    self.targets.select{|target| !target.influencer.facebook_id.blank?}
  end

  def targets_with_twitter
    self.targets.select{|target| !target.influencer.twitter.blank?}
  end

  def owner_have_mobile_phone
    errors.add(:user, "Precisamos do seu celular para que a equipe de curadoria possa entrar em contato.") if self.user.mobile_phone.blank?
  end

  def generate_short_url!
    self.update_attribute :short_url, Bitly.new(ENV['BITLY_ID'], ENV['BITLY_SECRET']).shorten(Rails.application.routes.url_helpers.campaign_url(self.id)).short_url
  end
end
