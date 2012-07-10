module Notification
  class User
    attr_accessor :link, :date
  end
end

module UsersHelper
  
  def timeline_objects(user)
    a = []
    user.pokes.each do |poke|
      b = Notification::User.new
      b.link = I18n.t('notification.campaign.poked', link: link_to(poke.campaign.name, campaign_path(poke.campaign)))
      b.date = poke.created_at
      a << b
    end
    user.campaigns.each do |campaign|
      b = Notification::User.new
      b.link = I18n.t('notification.campaign.created', link: link_to(campaign.name, campaign_path(campaign)))
      b.date = campaign.created_at
      a << b
    end

    a.sort! { |a,b| b.date <=> a.date }
  end

end
