# coding: utf-8
require 'httparty'

class Poke < ActiveRecord::Base
  

  attr_accessible :campaign_id,         :kind, :user_id, :custom_message
  belongs_to      :campaign
  belongs_to      :user
  has_many        :targets,     :through => :campaign
  has_many        :influencers, :through => :targets

  validates_presence_of :campaign
  validates_presence_of :user
  validates_presence_of :kind

  validate :poked_recently?, on: :create

  after_create    :thanks
  after_create    :send_email,          :if => Proc.new { self.email? }
  after_create    :send_facebook_post,  :if => Proc.new { self.facebook? }
  after_create    :if => Proc.new { self.twitter? } { self.delay.send_tweet }
  after_create    :if => Proc.new { self.phone? }   { self.delay.send_phone } 
  before_create   :post_facebook_activity
  
  default_scope order('updated_at DESC') 


  def thanks
    PokeMailer.delay.thanks(self)
  end

  def poked_recently?
    errors.add(:created_at, I18n.t('activerecord.errors.models.poke.attributes.created_at.poked_recently')) if not any_recent_pokes?.blank? 
  end

  def any_recent_pokes?
    pokes = Poke.where(user_id: self.user_id, campaign_id: self.campaign_id, kind: self.kind)
    pokes.select { |poke| poke.created_at > Time.now - 1.day }
  end


  def phone?
    self.kind == "phone"
  end

  def twitter?
    self.kind == "twitter"
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

  def first?
    Poke.where(:user_id => self.user_id, :campaign_id => self.campaign_id).count == 1
  end



  def user_phone
    "55#{self.user.mobile_phone.scan(/[0-9]+/).join}"
  end

  def campaign_phone
    "#{self.campaign.voice_call_number.scan(/[0-9]+/).join}"
  end
  
  private
  def send_phone
    service = ENV['SERVICE_CALL_URL']
    params  = {
      user:         self.user_phone,
      destination:  self.campaign_phone
    }

    response = HTTParty.get(service, query: params) 

    return response
    
  end

  def send_email
    PokeMailer.delay.poke(self)
    self.campaign.targets.each {|t| t.increase_pokes_by_email}
  end

  def send_facebook_post
    campaign_url = Rails.application.routes.url_helpers.campaign_url(campaign)
    campaign.targets_with_facebook.each do |t| 
      begin
        Koala::Facebook::API.new(user.facebook_authorization.token).delay.put_wall_post(self.message, {:link => campaign_url}, t.influencer.facebook_id)
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
        Twitter.update("#{t.influencer.twitter} #{self.campaign.twitter_text}: #{self.campaign.short_url}")
        t.increase_pokes_by_twitter
      rescue Exception => e
        puts e.message
      end
    end
  end

  def post_facebook_activity
    if self.user.facebook_authorization && self.first?
      begin
        campaign_url = Rails.application.routes.url_helpers.campaign_url(self.campaign)
        Koala::Facebook::API.new(self.user.facebook_authorization.token).delay.put_connections("me", "paneladepressao:apoiar", :campaign => campaign_url)
      rescue Exception => e
        puts "Post Facebook activity failed: #{e.message}"
      end
    end
  end
end
