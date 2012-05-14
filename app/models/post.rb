class Post < ActiveRecord::Base
   attr_accessible :campaign_id, :content

   belongs_to :campaign
   validates_presence_of :campaign_id, :content
end
