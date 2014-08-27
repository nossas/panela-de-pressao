module CampaignsHelper
  def moderated_class? campaign
  	'moderated' if campaign.moderated?
  end

  def user_path user
    "#{ENV['MEURIO_HOST']}/users/#{user.id}"
  end
end
