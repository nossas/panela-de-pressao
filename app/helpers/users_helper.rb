module Notification
  class User
    attr_accessor :link, :kind, :date
  end
end

module UsersHelper
  
  def timeline_objects(user)
    a = []
    user.pokes.limit(10).each do |poke|
      b = Notification::User.new
      b.link = I18n.t('notification.campaign.poked_html', through: poke.kind, link: campaign_path(poke.campaign), name: poke.campaign.name)
      b.date = poke.created_at
      b.kind = "icon-megaphone"
      a << b
    end
    user.campaigns.limit(10).each do |campaign|
      b = Notification::User.new
      b.link = I18n.t('notification.campaign.created_html', link: campaign_path(campaign), name: campaign.name)
      b.date = campaign.created_at
      b.kind = "icon-edit"
      a << b
    end

    a.sort! { |a,b| b.date <=> a.date }
  end

end
