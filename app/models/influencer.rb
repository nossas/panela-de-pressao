class Influencer < ActiveRecord::Base
  attr_accessible :email, :facebook, :name, :twitter, :role, :avatar, :avatar_cache
  has_many :targets
  has_many :campaigns, :through => :targets
  default_scope order("name")
  validates :name, :role, :presence => true
  mount_uploader :avatar, AvatarUploader

  def to_s
    "#{self.name}, #{self.role}"
  end

  def facebook_url
    "https://facebook.com/profile.php?id=#{self.facebook}"
  end

  def twitter_url
    "http://twitter.com/#{self.twitter}"
  end


end

