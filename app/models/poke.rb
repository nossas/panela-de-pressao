# coding: utf-8

class Poke < ActiveRecord::Base
  attr_accessible :campaign_id, :kind, :user_id, :custom_message
  after_create :send_email, :if => Proc.new {self.email?}
  after_create :send_facebook_post, :if => Proc.new {self.facebook?}
  after_create :send_tweet, :if => Proc.new {self.twitter?}
  belongs_to :campaign
  belongs_to :user
  has_many :targets, :through => :campaign
  has_many :influencers, :through => :targets

  before_create { PokeMailer.thanks(self).deliver unless self.user.has_poked(self.campaign) }
  
  default_scope order('updated_at DESC') 
  def twitter?
    self.kind == 'twitter'
  end

  def email?
    self.kind == "email"
  end
  
  def facebook?
    self.kind == "facebook"
  end

  private
  def send_email
    PokeMailer.poke(self).deliver
    self.campaign.targets.each {|t| t.increase_pokes_by_email}
  end

  def send_facebook_post
    campaign_url = Rails.application.routes.url_helpers.campaign_url(campaign)
    begin
      Koala::Facebook::API.new(user.facebook_authorization.token).put_wall_post(custom_message, {:link => campaign_url})
    rescue Exception => e
      puts e.message
    end
    campaign.targets.each do |t| 
      begin
        Koala::Facebook::API.new(user.facebook_authorization.token).put_wall_post(custom_message, {:link => campaign_url}, t.influencer.facebook)
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
    self.campaign.targets.select{|t| !t.influencer.twitter.blank?}.each do |t|
      begin
        Twitter.update("#{self.campaign.twitter_text}: #{self.campaign.short_url} #{t.influencer.twitter}")
        t.increase_pokes_by_twitter
      rescue Exception => e
        puts e.message
      end
    end
  end
end
