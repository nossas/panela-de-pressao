class Organization < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :cnpj
  validates_presence_of :address

  belongs_to :owner, :class_name => "User"

  attr_accessible :name, :cnpj, :address
end
