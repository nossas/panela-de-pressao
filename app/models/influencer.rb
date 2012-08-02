class Influencer < ActiveRecord::Base
  attr_accessible :email, :facebook_url, :facebook_id, :name, :twitter, :role, :avatar, :avatar_cache
  has_many :targets
  has_many :campaigns, :through => :targets
  validates :name, :role, :presence => true
  validates :facebook_url, :format => {:with => /facebook\.com\/.+/}, :allow_blank => true
  validates :twitter, :format => {:with => /@([A-Za-z0-9_]+)/}, :allow_blank => true
  validates :email, :format => {:with => /^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+.[a-zA-Z0-9-.]+$/}, :allow_blank => true
  default_scope order("name")
  mount_uploader :avatar, AvatarUploader
  before_save { self.facebook_id = Koala::Facebook::API.new.get_object(self.facebook_user)["id"] }

  def to_s
    "#{self.name}, #{self.role}"
  end

  def twitter_url
    "http://twitter.com/#{self.twitter}"
  end

  def facebook_user
    /facebook\.com\/(.+)/.match(self.facebook_url)[1]
  end
end

