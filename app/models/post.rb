class Post < ActiveRecord::Base
   attr_accessible :campaign_id, :content

   belongs_to :campaign
   validates_presence_of :campaign_id, :content

   auto_html_for :content do
     html_escape
     image
     youtube(:width => 400, :height => 250)
     link :target => "_blank", :rel => "nofollow"
     simple_format
   end
end
