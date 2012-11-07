class Campaign < ActiveRecord::Base
  include AutoHtml
  attr_accessible :description, :name, :user_id, :user_ids, :image, 
    :image_cache, :category_id, :target_ids, :influencer_ids, :short_url, 
    :email_text, :facebook_text, :twitter_text, :map_embed, :map_description, 
    :pokers_email, :finished_at, :succeed, :video_url

  has_and_belongs_to_many :users
  belongs_to :user
  belongs_to :category
  has_many :targets
  has_many :influencers, :through => :targets
  has_many :posts
  has_many :answers
  has_many :pokes
  has_many :pokers, through: :pokes, source: :user, uniq: true

  before_save  { self.description_html = convert_html(description) }
  after_create { self.delay.generate_short_url! }
  after_create { CampaignMailer.delay.campaign_awaiting_moderation(self) }
  after_create { CampaignMailer.delay.we_received_your_campaign(self) }

  accepts_nested_attributes_for :targets
  accepts_nested_attributes_for :influencers

  default_scope order("accepted_at DESC")

  scope :accepted,    where('accepted_at IS NOT NULL')
  scope :unmoderated, where(accepted_at: nil)
  scope :featured,    where('featured_at IS NOT NULL').reorder('featured_at DESC')
  scope :popular,     joins(:pokes).where(succeed: nil, finished_at: nil).group('campaigns.id').reorder('count(*) desc')
  scope :unfinished,  where('finished_at IS NULL')
  scope :successful,  where('succeed = true AND finished_at IS NOT NULL')
  mount_uploader :image, ImageUploader

  validates :name, :user_id, :description, :image, :category, :email_text, :facebook_text, :twitter_text, :presence => true  
  validates_format_of :video_url, with: /\A(?:http:\/\/)?(?:www\.)?(youtube\.com\/watch\?v=([a-zA-Z0-9_-]*))|(?:www\.)?vimeo\.com\/(\d+)\Z/, allow_blank: true
  validates_length_of :twitter_text, :maximum => 100
  validates_format_of :map_embed, with: /\A<iframe(.*)src=\"http(s)?:\/\/(maps.google.com\/maps)|(google.com\/maps).*\Z/i, allow_nil: true, allow_blank: true

  mount_uploader :image, ImageUploader

  validate :owner_have_mobile_phone

  def video
    video = VideoInfo.new(self.video_url.to_s)
    if video.valid? then return video.embed_code else return nil end
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

  def not_empty_influencer(opt = :email)
    self.influencers.select { |a| a.send(opt.to_s) != "" }    
  end

  def pokes_by(opt = :email)
    self.pokes.where(:kind => opt.to_s)
  end

  def finished?
    !self.finished_at.nil?
  end

  def targets_with_facebook
    self.influencers.select(&:facebook_id)
  end

  def targets_with_twitter
    self.influencers.select(&:twitter)
  end

  def owner_have_mobile_phone
    errors.add(:user, "Precisamos do seu celular para que a equipe de curadoria possa entrar em contato.") if self.user.mobile_phone.blank?
  end

  def generate_short_url!
    self.update_attribute :short_url, Bitly.new(ENV['BITLY_ID'], ENV['BITLY_SECRET']).shorten(Rails.application.routes.url_helpers.campaign_url(self.id)).short_url
  end

  def accept_now!
    self.accepted_at = Time.now
    self.save
    CampaignMailer.delay.campaign_accepted(self)
  end
end
