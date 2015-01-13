class Influencer < ActiveRecord::Base
  attr_accessible :email, :name, :twitter, :role, :avatar, :avatar_cache,
    :about, :facebook_url, :archived_at

	attr_accessor :user_id

  FACEBOOK_PAGE_REGEX = /(?:(?:http|https):\/\/)?(?:www.)?facebook.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[?\w\-]*\/)?(?:profile.php\?id=(?=\d.*))?([\w\-]*)?/

  has_many :targets
  has_many :campaigns, :through => :targets
  has_and_belongs_to_many :influencers_groups, -> { uniq }

  validates_presence_of :name
  validates_presence_of :role
  validates_format_of :twitter,       with: /\A@([A-Za-z0-9_]+)\Z/i, :allow_blank => true
  validates_format_of :email,         with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true
  validates_format_of :facebook_url,  with: FACEBOOK_PAGE_REGEX, :allow_blank => true

  default_scope { order("name") }
  scope :available, -> { where(archived_at: nil) }
  scope :archived, -> { where("archived_at IS NOT NULL") }

  mount_uploader :avatar, AvatarUploader

  include PgSearch
  multisearchable against: [:name, :role], unless: :archived?

  before_save :set_facebook_id

  def archive
    update_attribute :archived_at, (archived? ? nil : Time.now)
  end

  def archived?
    !!archived_at
  end

  def to_s
    "#{self.name}, #{self.role}"
  end

  def twitter_url
    "http://twitter.com/#{self.twitter}"
  end

  def facebook_user
    /facebook\.com\/(.+)/.match(self.facebook_url)[1] if !self.facebook_url.blank?
  end

  def set_facebook_id
    if self.facebook_url.present?
      self.facebook_id = Influencer::FACEBOOK_PAGE_REGEX.match(self.facebook_url)[1]
    else
      self.facebook_id = nil
    end
  end
end
