class Target < ActiveRecord::Base
  attr_accessible :campaign_id, :influencer_id, :pokes_by_email, :pokes_by_facebook, :pokes_by_twitter
  belongs_to :influencer
  belongs_to :campaign
  
  def increase_pokes_by_twitter
    self.update_attributes(:pokes_by_twitter => self.pokes_by_twitter.to_i + 1) if !self.influencer.twitter.blank?
  end

  def increase_pokes_by_email
    self.update_attributes(:pokes_by_email => self.pokes_by_email.to_i + 1) if !self.influencer.email.blank?
  end

  def increase_pokes_by_facebook
    self.update_attributes(:pokes_by_facebook => self.pokes_by_facebook.to_i + 1) if !self.influencer.facebook_id.blank?
  end
end
