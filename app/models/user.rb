class User < ActiveRecord::Base
  attr_accessible :admin, :email, :name, :picture, :about_me, :file
  has_many :authorizations
  has_many :campaigns
  has_many :pokes

  validates_presence_of :email, :name

  mount_uploader :file, ImageUploader

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
    self.carrierwave_pic(:type => type) || self.facebook_pic(:type => type) || self.picture || "http://meurio.org.br/assets/avatar_blank.png"
  end

  def carrierwave_pic options = {:type => "large"}
    self.file.send(options[:type]).url
  end

  def facebook_pic options = {:type => "large"}
    "http://graph.facebook.com/#{self.facebook_authorization.uid}/picture?type=#{options[:type]}" if self.facebook_authorization
  end

  def facebook_url
    "https://facebook.com/profile.php?id=#{self.facebook_authorization.uid}" if self.facebook_authorization
  end

  def twitter_authorization
    authorizations.where(:provider => "twitter").first
  end
  
  def pokes_counter
    attributes['pokes_count']
  end

  def has_poked campaign
    pokes.where(:campaign_id => campaign.id).any?
  end
end
