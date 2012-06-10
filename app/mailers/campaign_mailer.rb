# coding: utf-8
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

  def campaign_awaiting_moderation campaign
    @campaign = campaign
    mail(
      :to => "curadoria@seurio.com.br",
      :subject => "Campanha aguardando moderação",
      :from => "contato@seurio.com.br"
    )
  end

  def we_received_your_campaign campaign
    @campaign = campaign
    mail(
      :to => campaign.user.email,
      :subject => "Recebemos a sua campanha",
      :from => "contato@seurio.com.br"
    )
  end

end
