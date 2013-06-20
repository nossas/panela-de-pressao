class Update < ActiveRecord::Base
  attr_accessible :body, :campaign_id, :image, :title
  belongs_to :campaign
  validates :body, :campaign_id, :title, presence: true
  mount_uploader :image, UpdateImageUploader
  
  auto_html_for :video do
    youtube(:width => "100%")
  end
end
