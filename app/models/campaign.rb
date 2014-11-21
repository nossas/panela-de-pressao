class Campaign < ActiveRecord::Base
  include AutoHtml
  attr_accessible :description, :name, :user_id, :user_ids, :image,
    :image_cache, :category_id, :target_ids, :influencer_ids, :short_url,
    :email_text, :facebook_text, :twitter_text, :map_embed, :map_description,
    :pokers_email, :finished_at, :succeed, :video_url, :moderator_id, :archived_at,
    :voice_call_script, :voice_call_number, :hashtag, :poke_type, :organization_id,
    :facebook_share_title, :facebook_share_lead, :facebook_share_thumb,
    :after_poke_title, :after_poke_text, :after_poke_link, :after_poke_call_to_action

  has_many :users, through: :campaign_owners
  has_many :campaign_owners
  belongs_to :user
  belongs_to :category
  belongs_to :moderator, :class_name => "User"
  belongs_to :organization
  has_many :targets
  has_many :influencers, through: :targets

  has_many(
    :twitter_influencers,
    -> { where "COALESCE(influencers.twitter, '') <> ''" },
    through: :targets,
    source: :influencer
  )

  has_many(
    :facebook_influencers,
    -> { where "COALESCE(influencers.facebook_id, '') <> ''" },
    through: :targets,
    source: :influencer
  )

  has_many(
    :email_influencers,
    -> { where "COALESCE(influencers.email, '') <> ''" },
    through: :targets,
    source: :influencer
  )

  has_many :posts
  has_many :answers
  has_many :pokes
  has_many :updates
  has_many :reports
  has_many :pokers, -> { uniq }, through: :pokes, source: :user

  before_save  { self.description_html = convert_html(description) }
  after_create { self.delay.generate_short_url! }
  after_create { CampaignMailer.delay.we_received_your_campaign(self) }
  after_create { CampaignMailer.delay.new_campaign(self) }
  after_create { self.delay.create_mailchimp_segment }
  after_update { self.delay.update_mailchimp_segment }

  accepts_nested_attributes_for :targets, :influencers

  default_scope { order("created_at DESC") }

  scope(
    :featured,
    -> {
      where('featured_at IS NOT NULL')
      .reorder('featured_at DESC')
    }
  )

  scope(
    :popular,
    -> {
      joins(:pokes)
      .where(succeed: nil, finished_at: nil)
      .group('campaigns.id')
      .reorder('count(*) desc')
    }
  )

  scope :moderated, -> { where('moderator_id IS NOT NULL') }
  scope :unmoderated, -> { where(moderator_id: nil) }
  scope :unfinished, -> { where(finished_at: nil) }
  scope :successful, -> { where('succeed = true AND finished_at IS NOT NULL') }
  scope :unarchived, -> { where(archived_at: nil) }
  scope :orphan, -> { where(moderator_id: nil) }
  scope :reported, -> { joins(:reports) }
  scope :moderated_first, -> { unscoped.order('CASE WHEN moderator_id IS NOT NULL THEN 1 ELSE NULL END') }

  validates :name, :user_id, :description, :image, :category_id, :poke_type, :organization_id, :presence => true
  validates_length_of :twitter_text, :maximum => 100
  validates_format_of :map_embed, with: /\A<iframe(.*)src=\"http(s)?:\/\/(maps.google.com\/maps)|(google.com\/maps).*\Z/i, allow_nil: true, allow_blank: true
  validate :owner_have_mobile_phone, on: :create
  validates :email_text, presence: true, if: Proc.new{ poke_type?("email") }
  validates :facebook_text, presence: true, if: Proc.new{ poke_type?("facebook") }
  validates :twitter_text, presence: true, if: Proc.new{ poke_type?("twitter") }

  mount_uploader :image, ImageUploader
  mount_uploader :facebook_share_thumb, FacebookThumbUploader

  def video
    video = VideoInfo.get(self.video_url.to_s)
    return video.embed_code unless video.nil?
  end

  def convert_html(text)
    auto_html text do
      image
      youtube(width: "100%", height: 300)
      redcarpet :target => :_blank
    end
  end

  def pokes_by(opt = :email)
    self.pokes.where(:kind => opt.to_s)
  end

  def finished?
    !self.finished_at.nil?
  end

  def featured?
    !self.featured_at.nil?
  end

  def targets_with_facebook
    self.targets.select{|target| !target.influencer.facebook_id.blank?}
  end

  def targets_with_twitter
    self.targets.select{|target| !target.influencer.twitter.blank?}
  end

  def owner_have_mobile_phone
    errors.add(:user, "Precisamos do seu celular para que a equipe de curadoria possa entrar em contato.") if self.user.phone.blank?
  end

  def generate_short_url!
    self.update_attribute :short_url, Bitly.new(ENV['BITLY_ID'], ENV['BITLY_SECRET']).shorten(Rails.application.routes.url_helpers.campaign_url(self.id)).short_url
  end

  def archived?
    !self.archived_at.nil?
  end

  def has_voice_action?
    self.voice_call_number.present? && self.voice_call_script.present?
  end

  def user_email
    user.email
  end

  def after_poke_customized?
    self.after_poke_title.present? and self.after_poke_text.present? and self.after_poke_link.present? and self.after_poke_call_to_action.present?
  end

  def as_json options
    super(methods: [:user_email])
  end

  def create_mailchimp_segment
    begin
      segment = Gibbon::API.lists.segment_add(
        id: self.organization.mailchimp_list_id,
        opts: {
          type: "static",
          name: self.mailchimp_segment_name
        }
      )
      self.update_attribute :mailchimp_segment_uid, segment["id"]
    rescue Exception => e
      Appsignal.add_exception e
      Rails.logger.error e
    end
  end

  def update_mailchimp_segment
    begin
      Gibbon::API.lists.segment_update(
        id: self.organization.mailchimp_list_id,
        seg_id: self.mailchimp_segment_uid,
        opts: { name: mailchimp_segment_name }
      )
    rescue Exception => e
      Appsignal.add_exception e
      Rails.logger.error e
    end
  end

  def mailchimp_segment_name
    "PDP - #{self.id.to_s.rjust(4, "0")} - #{self.organization.city} - #{self.name}"[0..99]
  end

  def poke_type? type
    poke_type == type
  end

  def users
    @users ||= [self.user].concat(CampaignOwner.where(campaign_id: self.id).map{|co| co.user})
  end

  def failed?
    succeed == false
  end

  def moderated?
    !!self.moderator_id
  end
end
