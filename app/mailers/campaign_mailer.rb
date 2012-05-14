class CampaignMailer < ActionMailer::Base
  default from: "from@example.com"

  def campaign_accepted campaign
    @campaign = campaign
    mail(
      :to => campaign.user.email,
      :subject => "Sua campanha foi aprovada!",
      :from => "contato@seurio.com.br"
    )
  end
end
