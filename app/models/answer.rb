class Answer < ActiveRecord::Base
  include AutoHtml
  attr_accessible :campaign_id, :text
  before_save do 
		self.text_html = auto_html(text) do
      image
      youtube(width: "100%", height: 300)
      redcarpet :target => :_blank
		end
	end
end
