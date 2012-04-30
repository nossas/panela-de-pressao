class Poke < ActiveRecord::Base
  attr_accessible :campaign_id, :kind, :user_id
  after_create :send_email, :if => Proc.new {self.email?}
  belongs_to :campaign
  belongs_to :user
  has_many :targets, :through => :campaign
  has_many :influencers, :through => :targets

  def email?
    self.kind == "email"
  end

  private
  def send_email
    PokeMailer.poke(self).deliver
  end
end
