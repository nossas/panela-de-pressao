# coding: utf-8

class Poke < ActiveRecord::Base
  attr_accessible :campaign_id, :kind, :user_id, :custom_message, :created_at
  after_create :send_email, :if => Proc.new {self.email?}
  after_create :send_facebook_post, :if => Proc.new {self.facebook?}
  after_create :if => Proc.new {self.twitter?} { self.send_tweet }
  belongs_to :campaign
  belongs_to :user
  has_many :targets, :through => :campaign
  has_many :influencers, :through => :targets

  validates_presence_of :campaign
  validates_presence_of :user
  validates_presence_of :kind

  validate :poked_recently?, on: :create

  before_create { PokeMailer.thanks(self) unless self.user.has_poked(self.campaign) }
  before_create :post_facebook_activity
  
  default_scope order('updated_at DESC') 



  def poked_recently?
    errors.add(:created_at, I18n.t('activerecord.errors.models.poke.attributes.created_at.poked_recently')) if not any_recent_pokes?.blank? 
  end

  def any_recent_pokes?
    pokes = Poke.where(user_id: self.user_id, campaign_id: self.campaign_id, kind: self.kind)
    pokes.select { |poke| poke.created_at > Time.now - 15.minutes }
  end

  def twitter?
    self.kind == 'twitter'
  end

  def email?
    self.kind == "email"
  end
  
  def facebook?
    self.kind == "facebook"
  end

  def message
    return self.custom_message unless self.custom_message.blank?
    return self.campaign.email_text if self.email?
    return self.campaign.facebook_text if self.facebook?
    return self.campaign.twitter_text if self.twitter?
  end

  private
  def send_email
    PokeMailer.poke(self)
    self.campaign.targets.each {|t| t.increase_pokes_by_email}
  end

  def send_facebook_post
    campaign_url = Rails.application.routes.url_helpers.campaign_url(campaign)
    campaign.targets_with_facebook.each do |t| 
      begin
        Koala::Facebook::API.new(user.facebook_authorization.token).put_wall_post(self.message, {:link => campaign_url}, t.influencer.facebook_id)
        t.increase_pokes_by_facebook
      rescue Exception => e
        puts e.message
      end
    end
  end

  def send_tweet
    Twitter.configure do |c|
      c.oauth_token = user.twitter_authorization.token
      c.oauth_token_secret = user.twitter_authorization.secret
    end
    self.campaign.targets_with_twitter.each do |t|
      begin
        Twitter.update("#{self.campaign.twitter_text}: #{self.campaign.short_url} #{t.influencer.twitter}")
        t.increase_pokes_by_twitter
      rescue Exception => e
        puts e.message
      end
    end
  end

  def post_facebook_activity
    if self.user.facebook_authorization
      begin
        campaign_url = Rails.application.routes.url_helpers.campaign_url(self.campaign)
        Koala::Facebook::API.new(self.user.facebook_authorization.token).put_connections("me", "paneladepressao:apoiar", :campanha => campaign_url)
      rescue Exception => e
        puts "Post Facebook activity failed: #{e.message}"
      end
    end
  end
end
