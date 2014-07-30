class Update < ActiveRecord::Base
  attr_accessible :body, :campaign_id, :image, :title, :video, :lead, :user_id
  belongs_to :campaign
  belongs_to :user
  validates :body, :campaign_id, :title, :lead, :user_id, presence: true
  mount_uploader :image, UpdateImageUploader
  default_scope { order("created_at DESC") }

  auto_html_for :video do
    youtube(:width => "100%")
  end

  auto_html_for :body do
    html_escape
    image
    youtube(:width => "100%")
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end

  def thumb
    if self.video.blank?
      self.image.thumb.url
    else
      "http://img.youtube.com/vi/#{self.video[/(?<=[?&]v=)[^&$]+/]}/0.jpg"
    end
  end
end
