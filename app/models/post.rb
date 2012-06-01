class Post < ActiveRecord::Base
   attr_accessible :campaign_id, :content

   belongs_to :campaign
   validates_presence_of :campaign_id, :content
   default_scope order("created_at DESC")

   auto_html_for :content do
     google_map(:width => '100%', :height => 350, :link_text => 'ver mapa maior')
     redcarpet
     simple_format
   end
end
