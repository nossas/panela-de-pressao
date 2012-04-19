class Issue < ActiveRecord::Base
  attr_accessible :description, :name, :user_id
  
  belongs_to :user
  belongs_to :organization
end
