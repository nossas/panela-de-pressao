class Update < ActiveRecord::Base
  attr_accessible :body, :campaign_id, :image, :title, :video
  belongs_to :campaign
  validates :body, :campaign_id, :title, presence: true
  mount_uploader :image, UpdateImageUploader
  
  auto_html_for :video do
    youtube(:width => "100%")
  end

  def thumb
    if self.video.blank?
      self.image.thumb.url
    else
      "http://img.youtube.com/vi/#{self.video[/(?<=[?&]v=)[^&$]+/]}/0.jpg"
    end
  end
end
