class OrganizationMember < ActiveRecord::Base
  attr_accessible :organization_id, :user_id

  validates_presence_of :organization_id, :user_id
  belongs_to :organization
  belongs_to :user
end
