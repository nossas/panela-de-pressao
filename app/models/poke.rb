class Poke < ActiveRecord::Base
  attr_accessible :campaign_id, :kind, :user_id
  after_create :send_email, :if => Proc.new {self.email?}
  after_create :post_on_facebook, :if => Proc.new {self.facebook?}
  after_create :update_targets
  belongs_to :campaign
  belongs_to :user
  has_many :targets, :through => :campaign
  has_many :influencers, :through => :targets

  def email?
    self.kind == "email"
  end
  
  def facebook?
    self.kind == "facebook"
  end

  private
  def send_email
    PokeMailer.poke(self).deliver
  end

  def post_on_facebook
    if !Rails.env.test? 
      campaign.influencers.each do |i| 
        begin
          Koala::Facebook::API.new(user.facebook_authorization.token).put_connections(i.facebook, "links", :link => Rails.application.routes.url_helpers.campaign_url(campaign))
        rescue
        end
      end
      begin
        Koala::Facebook::API.new(user.facebook_authorization.token).put_connections("me", "links", :link => Rails.application.routes.url_helpers.campaign_url(campaign))
      rescue
      end
    end
  end

  def update_targets
    self.campaign.targets.each {|t| t.increase_pokes_by_email} if email?
    self.campaign.targets.each {|t| t.increase_pokes_by_facebook} if facebook?
  end
end
