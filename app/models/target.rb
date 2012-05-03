class Target < ActiveRecord::Base
  attr_accessible :campaign_id, :influencer_id, :pokes_by_email
  belongs_to :influencer
  belongs_to :campaign
  
  def increase_pokes_by_email
    self.update_attributes(:pokes_by_email => self.pokes_by_email + 1) if !self.influencer.email.blank?
  end
end
