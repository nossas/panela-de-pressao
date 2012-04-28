class Influencer < ActiveRecord::Base
  attr_accessible :email, :facebook, :name, :twitter
  has_many :targets
  has_many :campaigns, :through => :targets
end
