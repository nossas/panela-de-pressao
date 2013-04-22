class Authorization < ActiveRecord::Base
  attr_accessible :user, :uid, :provider, :token, :secret
  belongs_to :user
  validates_presence_of :user_id, :uid, :provider, :token
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_from_hash(hash)
    find_by_provider_and_uid(hash['provider'], hash['uid'])
  end

  def self.create_from_hash(hash, user = nil)
    user ||= User.find_by_email(hash['info']['email']) || User.create_from_hash!(hash)
    Authorization.create(:user => user, :uid => hash['uid'], :provider => hash['provider'], :token => hash['credentials']['token'], :secret => hash['credentials']['secret'])
  end
end
