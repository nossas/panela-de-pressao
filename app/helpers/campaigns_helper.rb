module CampaignsHelper
  def moderated_class? campaign
  	'moderated' if campaign.moderated?
  end

  def user_path user
    "http://#{ENV['MEURIO_DOMAIN']}/users/#{user.id}"
  end
end
