class User < ActiveRecord::Base
  establish_connection Rails.env.production? ? ENV["ACCOUNTS_DATABASE"] : "accounts_#{Rails.env}"
  attr_accessible :admin, :email, :name, :picture, :about_me, :file, :remove_file, :phone, :token, :subscriber
  has_many :authorizations
  has_many :campaigns
  has_many :pokes
  has_many :recomendations
  has_and_belongs_to_many :collaborations, :class_name => "Campaign"

  validates_uniqueness_of :email

  scope :by_campaign_id, ->(campaign) { joins(:pokes).where(['pokes.campaign_id = ?', campaign]).uniq }
  scope :subscribers, where(:subscriber => true)
  scope :pokers, where("(SELECT count(*) FROM pokes WHERE pokes.user_id = users.id) > 0")

  def self.create_from_hash!(hash)
    create!(
      :email =>   hash['info']['email']
    )
  end

  def name
    "#{first_name} #{last_name}"
  end

  def avatar_url
    "https://meurio-accounts.s3.amazonaws.com/uploads/user/avatar/#{self.id}/square_#{self.avatar}"
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
end
