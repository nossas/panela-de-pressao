class Poke < ActiveRecord::Base
  attr_accessible :campaign_id, :kind, :user_id
  after_create :send_email, :if => Proc.new {self.email?}
  after_create :send_tweet, :if => Proc.new {self.twitter?}
  after_create :update_targets
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
  end

  def send_tweet
    Twitter.update("test tweet")
  end

  def update_targets
    self.campaign.targets.each {|t| t.increase_pokes_by_email}
  end
end
