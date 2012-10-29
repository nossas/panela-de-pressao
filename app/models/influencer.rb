class Influencer < ActiveRecord::Base
  attr_accessible :email, :name, :twitter, :role, :avatar, :avatar_cache, :about, :facebook_url
	attr_accessor :user_id

  has_many :targets
  has_many :campaigns, :through => :targets

  validates_presence_of :name
  validates_presence_of :role
  validates_format_of :twitter,       with: /\A@([A-Za-z0-9_]+)\Z/i, :allow_blank => true
  validates_format_of :email,         with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :allow_blank => true
  validates_format_of :facebook_url,  with: /facebook\.com\/.+/, :allow_blank => true

	before_save do 
		if self.facebook_url_changed? && !self.facebook_url.blank?
			@facebook_url_temp = self.facebook_url
			self.facebook_url = self.facebook_url_was
			@user_id = self.user_id 
		end
	end

	after_save { self.delay.update_facebook(@facebook_url_temp, :by => @user_id) if @facebook_url_temp }

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

  def update_facebook url, options = {}
    graph = Koala::Facebook::API.new ENV["FB_TOKEN"]
    page = graph.get_object(url.match(/(?:http:\/\/)?(?:www\.)?facebook\.com\/(?:(?:\w)*#!\/)?(?:pages\/)?(?:[\w\-]*\/)*([\w\-]*)/)[1])
		end
    if page["can_post"]
			self.update_column :facebook_url, page["link"]
      self.update_column :facebook_id, page["id"]
    else
      InfluencerMailer.delay.facebook_was_not_updated(self, options[:by], url) if options[:by]
    end
  end
end

