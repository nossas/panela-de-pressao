class Influencer < ActiveRecord::Base
  attr_accessible :email, :facebook, :name, :twitter, :role, :avatar, :avatar_cache
  has_many :targets
  has_many :campaigns, :through => :targets
  has_many :organizations, :foreign_key => "owner_id"
  default_scope order("name")
  validates :name, :role, :presence => true
  mount_uploader :avatar, AvatarUploader

  def to_s
    "#{self.name}, #{self.role}"
  end
end
