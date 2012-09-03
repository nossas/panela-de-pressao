class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :picture, :about_me, :file, :remove_file
  has_many :authorizations
  has_many :campaigns
  has_many :pokes

  scope :by_campaign_id, lambda {|id| Campaign.find(id).pokers }

  validates_presence_of :email, :name

  mount_uploader :file, AvatarUploader

  def self.create_from_hash!(hash)
    create!(
      :email => hash['info']['email'],
      :name => "#{hash['info']['first_name']} #{hash['info']['last_name']}",
      :picture => hash['info']['image_url'] || hash['info']['image']
    )
  end

  def facebook_authorization
    authorizations.where(:provider => "facebook").first
  end

  def pic options = {:type => "large"}
    type = options[:type]
    self.carrierwave_pic(:type => type) || self.picture.try{|p| p.gsub("square", type.to_s)} || "http://meurio.org.br/assets/avatar_blank.png"
  end

  def carrierwave_pic options = {:type => "large"}
    self.file.send(options[:type]).url
  end

  def twitter_authorization
    authorizations.where(:provider => "twitter").first
  end
  
  def pokes_counter
    attributes['pokes_count']
  end

  def has_poked campaign
    self.pokes.where(:campaign_id => campaign.id).any?
  end

  def can_poke? campaign, options = {}
    self.pokes.where("campaign_id = ? AND kind = ? AND created_at >= ?", campaign.id, options[:with], Time.now - 1.day).count == 0
  end
end
