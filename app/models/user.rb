class User < ActiveRecord::Base
  has_many :authorizations
  has_many :campaigns
  has_many :organizations, :foreign_key => "owner_id"
  validates_presence_of :email, :name

  def self.create_from_hash!(hash)
    create!(
          :email => hash['info']['email'],
          :name => "#{hash['info']['first_name']} #{hash['info']['last_name']}",
          :picture => hash['info']['image_url'] || hash['info']['image']
          )
  end

  def facebook_authorization
    Authorization.where(:provider => "facebook").first
  end
end
