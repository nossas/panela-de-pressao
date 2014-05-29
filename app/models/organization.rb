class Organization < ActiveRecord::Base
  has_many :campaigns

  def self.random_moderator
  	where("id IN (?)", Campaign.pluck(:organization_id).compact.uniq).order("random()").first
  end

  def moderations
  	self.campaigns.where('moderator_id IS NOT NULL')
  end

  def avatar_url
    if self.avatar
      "https://#{ENV['ACCOUNTS_BUCKET']}.s3.amazonaws.com/uploads/organization/avatar/#{self.id}/square_#{self.avatar}"
    else
      "http://i.imgur.com/lsAFCHL.jpg"
    end
  end
end
