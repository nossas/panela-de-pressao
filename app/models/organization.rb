class Organization < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name

  belongs_to :owner, :class_name => "Influencer"

end
