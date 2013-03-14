class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :picture, :about_me, :file, :remove_file, :mobile_phone, :token, :subscriber
  has_many :authorizations
  has_many :campaigns
  has_many :pokes
  has_and_belongs_to_many :collaborations, :class_name => "Campaign"

  validates_presence_of :email, :name
  validates_format_of :mobile_phone, with: /\A\(\d{2}\) \d{4}\-\d{4}\z/, allow_blank: true

  scope :by_campaign_id, ->(campaign) { joins(:pokes).where(['pokes.campaign_id = ?', campaign]).uniq }
  scope :subscribers, where(:subscriber => true)

  mount_uploader :file, AvatarUploader

  before_create { self.token = Digest::MD5.hexdigest(Time.now.to_s) }

  def self.create_from_hash!(hash)
    create!(
      :email =>   hash['info']['email'],
      :name =>    "#{hash['info']['first_name']} #{hash['info']['last_name']}",
      :picture => hash['info']['image']
    )
  end


  def facebook_authorization
    authorizations.where(:provider => "facebook").first
  end

  def pic options = {:type => "large"}
    type = options[:type]
    self.carrierwave_pic(:type => type) || self.picture.try{|p| p.gsub("square", type.to_s)} || "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(self.email)}?default=identicon"
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
