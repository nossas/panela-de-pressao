# coding: utf-8
require 'httparty'

class Poke < ActiveRecord::Base
  attr_accessible :campaign_id, :kind, :user_id, :custom_message
  belongs_to      :campaign
  belongs_to      :user
  has_many        :targets,     :through => :campaign
  has_many        :influencers, :through => :targets

  validates_presence_of :campaign
  validates_presence_of :user
  validates_presence_of :kind
  validate :frequency_validation, unless: :phone?

  before_create   :post_facebook_activity
  after_create    :thanks
  after_create    :send_email,          :if => Proc.new { self.email? }
  after_create    :send_facebook_post,  :if => Proc.new { self.facebook? }
  after_create    :if => Proc.new { self.twitter? } { self.delay.send_tweet }
  after_create    :if => Proc.new { self.phone? }   { self.delay.send_phone }
  after_create    { self.delay.add_to_mailchimp_segment }
  after_create    { self.delay.sync_reward }

  default_scope { order('updated_at DESC') }

  def self.valid_frequency?(user_id, campaign_id)
    Poke
    .where(user_id: user_id)
    .where(campaign_id: campaign_id)
    .where("created_at >= ?", Date.today)
    .empty?
  end

  def thanks
    PokeMailer.delay.thanks(self) if self.user.email.present?
  end

  def frequency_validation
    unless Poke.valid_frequency?(self.user_id, self.campaign_id)
      errors.add(:created_at, I18n.t('activerecord.errors.models.poke.attributes.created_at.poked_recently'))
    end
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
    "55#{self.user.phone.scan(/[0-9]+/).join}"
  end

  def campaign_phone
    "#{self.campaign.voice_call_number.scan(/[0-9]+/).join}"
  end

  def as_json options
    super({include: :user}.merge(options))
  end

  def add_to_mailchimp_segment
    begin
      self.create_membership

      # TODO: move all the MailChimp integration to Accounts
      Gibbon::API.lists.static_segment_members_add(
        id: self.campaign.organization.mailchimp_list_id,
        seg_id: self.campaign.mailchimp_segment_uid,
        batch: [{ email: self.user.email }]
      )
    rescue Exception => e
      Rails.logger.error e
    end
  end

  def create_membership
    begin
      url = "#{ENV["ACCOUNTS_HOST"]}/users/#{self.user_id}/memberships.json"
      body = { token: ENV["ACCOUNTS_API_TOKEN"], membership: { organization_id: self.campaign.organization_id } }
      HTTParty.post(url, body: body.to_json, headers: { 'Content-Type' => 'application/json' })
    rescue Exception => e
      logger.error e.message
    end
  end

  def sync_reward
    begin
      url = "#{ENV["MEURIO_HOST"]}/rewards.json"
      reward = { task_type_id: ENV['POKE_TASK_TYPE_ID'], user_id: self.user_id, points: "15", source_app: "Panela de Pressão", source_model: "Poke", source_id: self.id }
      body = { token: ENV["MEURIO_API_TOKEN"], reward: reward }
      response = HTTParty.post(url, body: body)
      self.update_attribute :rewarded, true if response.code == 201
    rescue Exception => e
      Rails.logger.error e
    end
  end

  private
  def send_phone
    service = ENV['SERVICE_CALL_URL']
    params = { user: self.user_phone, destination: self.campaign_phone }
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
