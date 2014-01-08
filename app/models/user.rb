class User < ActiveRecord::Base
  establish_connection Rails.env.production? ? ENV["ACCOUNTS_DATABASE"] : "accounts_#{Rails.env}"
  attr_accessible :admin, :email, :phone, :first_name, :last_name
  has_many :authorizations
  has_many :campaigns
  has_many :pokes
  has_many :recomendations
  has_and_belongs_to_many :collaborations, :class_name => "Campaign"

  validates_uniqueness_of :email

  scope :by_campaign_id, ->(campaign_id) { Poke.where(campaign_id: campaign_id).map{|p| p.user} }
  scope :subscribers, where(:subscriber => true)
  scope :pokers, where("(SELECT count(*) FROM pokes WHERE pokes.user_id = users.id) > 0")

  def self.create_from_hash!(hash)
    create!(
      :email =>       hash['info']['email'],
      :first_name =>  hash['info']['first_name'],
      :last_name =>   hash['info']['last_name']
    )
  end

  def name
    "#{self.first_name} #{self.last_name}"
  end

  def avatar_url
    if self.avatar
      "https://meurio-accounts.s3.amazonaws.com/uploads/user/avatar/#{self.id}/square_#{self.avatar}"
    else
      "http://i.imgur.com/lsAFCHL.jpg"
    end
  end

  def facebook_authorization
    authorizations.where(:provider => "facebook").first
  end

  def carrierwave_pic options = {:type => "large"}
    self.file.send(options[:type]).url
  end

  def twitter_authorization
    authorizations.where(:provider => "twitter").first
  end

  def has_poked campaign
    self.pokes.where(:campaign_id => campaign.id).any?
  end

  def can_poke? campaign, options = {}
    self.pokes.where("campaign_id = ? AND kind = ? AND created_at >= ?", campaign.id, options[:with], Time.now - 1.day).size == 0
  end

  def reported? campaign
    campaign.reports.where(user_id: id).any?
  end
end
