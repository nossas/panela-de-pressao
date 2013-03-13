class Recomendation < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user
  belongs_to :campaign
  belongs_to :source, :class_name => "Campaign"
end
