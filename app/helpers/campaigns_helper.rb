module CampaignsHelper
  def moderated_class? campaign
  	'moderated' if campaign.moderated?
  end
end