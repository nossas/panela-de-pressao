class Influencer < ActiveRecord::Base
  attr_accessible :email, :facebook_url, :facebook_id, :name, :twitter, :role, :avatar, :avatar_cache

  has_many :targets
  has_many :campaigns, :through => :targets

  validates_presence_of :name
  validates_presence_of :role
  validates_format_of :twitter,       with: /\A@([A-Za-z0-9_]+)\Z/i, :allow_blank => true
  validates_format_of :email,         with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true
  validates_format_of :facebook_url,  with: /facebook\.com\/.+/, :allow_blank => true

  # Callbacks

  before_save :setup_facebook_id 
  after_create { InfluencerMailer.created(self).deliver }
  after_update { InfluencerMailer.edited(self).deliver  }

  default_scope order("name")

  mount_uploader :avatar, AvatarUploader

  def to_s
    "#{self.name}, #{self.role}"
  end

  def twitter_url
    "http://twitter.com/#{self.twitter}"
  end

  def facebook_user
    /facebook\.com\/(.+)/.match(self.facebook_url)[1] if !self.facebook_url.blank?
  end

  private
    def setup_facebook_id
      self.facebook_id = Koala::Facebook::API.new.get_object(self.facebook_user)["id"] if self.facebook_user
    end
end

