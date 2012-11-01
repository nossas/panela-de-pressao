# coding: utf-8
class CampaignMailer < ActionMailer::Base
  default from: "from@example.com"

  def campaign_accepted campaign
    @campaign = campaign
    mail(
      :to => campaign.user.email,
      :subject => "Sua campanha foi aprovada!",
      :from => "contato@paneladepressao.org.br"
    )
  end

  def campaign_awaiting_moderation campaign
    @campaign = campaign
    mail(
      :to => "curadoria@paneladepressao.org.br",
      :subject => "Campanha aguardando moderação",
      :from => "contato@paneladepressao.org.br"
    )
  end

  def we_received_your_campaign campaign
    @campaign = campaign
    mail(
      :to => campaign.user.email,
      :subject => "Recebemos a sua campanha",
      :from => "contato@paneladepressao.org.br"
    )
  end

  def report campaign
    @campaign = campaign
    mail(
      :to => campaign.user.email,
      :subject => "Relatório da sua campanha no Panela de Pressão",
      :from => "contato@paneladepressao.org.br"
    )
  end
end
