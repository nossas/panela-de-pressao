class Influencer < ActiveRecord::Base
  attr_accessible :email, :facebook, :name, :twitter, :role
  has_many :targets
  has_many :campaigns, :through => :targets
  default_scope order("name")
  validates :name, :role, :presence => true

  def to_s
    "#{self.name}, #{self.role}"
  end
end
