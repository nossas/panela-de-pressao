class Poke < ActiveRecord::Base
  attr_accessible :campaign_id, :kind, :user_id
  after_create :send_email, :if => Proc.new {self.email?}
  after_create :send_tweet, :if => Proc.new {self.twitter?}
  belongs_to :campaign
  belongs_to :user
  has_many :targets, :through => :campaign
  has_many :influencers, :through => :targets

  def twitter?
    self.kind == 'twitter'
  end

  def email?
    self.kind == "email"
  end

  private
  def send_email
    PokeMailer.poke(self).deliver
    self.campaign.targets.each {|t| t.increase_pokes_by_email}
  end

  def send_tweet
    self.campaign.targets.each do |t|
      Twitter.update("@#{t.influencer.twitter} #{self.campaign.description}")
      t.increase_pokes_by_twitter
    end
  end
end
