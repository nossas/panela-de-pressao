class Update < ActiveRecord::Base
  attr_accessible :body, :campaign_id, :image, :title, :video, :share_text, :lead, :user_id, :facebook_post_uid
  belongs_to :campaign
  belongs_to :user
  validates :body, :campaign_id, :title, :share_text, :lead, :user_id, presence: true
  mount_uploader :image, UpdateImageUploader
  default_scope order("created_at DESC")
  after_save {|update| self.delay.post_on_facebook if update.facebook_post_uid.nil? }
  
  auto_html_for :video do
    youtube(:width => "100%")
  end

  def post_on_facebook
    user_graph = Koala::Facebook::API.new(self.user.facebook_authorization.token)
    page_token = user_graph.get_page_access_token(ENV["FACEBOOK_PAGE_ID"])
    page_graph = Koala::Facebook::API.new(page_token)
    facebook_post = page_graph.put_connections(
      ENV["FACEBOOK_PAGE_ID"], 
      'feed', 
      :message => self.share_text,
      :link => Rails.application.routes.url_helpers.updates_campaign_url(self.campaign, anchor: "update_#{self.id}", update_id: self.id)
    )
    self.update_attributes facebook_post_uid: facebook_post["id"]
  end

  def thumb
    if self.video.blank?
      self.image.thumb.url
    else
      "http://img.youtube.com/vi/#{self.video[/(?<=[?&]v=)[^&$]+/]}/0.jpg"
    end
  end
end
