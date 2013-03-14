# coding: utf-8
class CampaignMailer < ActionMailer::Base
  default from: "from@example.com"
  layout 'mailer'

  def campaign_accepted campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"campaign_accepted\"] }"
    @campaign = campaign
    mail(
      :to => campaign.user.email,
      :subject => "Sua campanha foi aprovada!",
      :from => "contato@paneladepressao.org.br"
    )
  end

  def campaign_awaiting_moderation campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"campaign_awaiting_moderation\"] }"
    @campaign = campaign
    mail(
      :to => "curadoria@paneladepressao.org.br",
      :subject => "Campanha aguardando moderação",
      :from => "contato@paneladepressao.org.br"
    )
  end
  
  def campaigns_without_moderator
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"campaigns_without_moderator\"] }"
    @campaigns = Campaign.orphan.unmoderated.unarchived
    mail(
      :to => "curadoria@paneladepressao.org.br",
      :subject => "Campanhas sem moderador",
      :from => "contato@paneladepressao.org.br"
    )
  end

  def we_received_your_campaign campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"we_received_your_campaign\"] }"
    @campaign = campaign
    mail(
      :to => campaign.user.email,
      :subject => "Recebemos a sua campanha",
      :from => "contato@paneladepressao.org.br"
    )
  end

  def report campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"campaign_report\"] }"
    @campaign = campaign
    mail(
      :to => campaign.user.email,
      :subject => "Relatório da sua campanha",
      :from => "contato@paneladepressao.org.br"
    )
  end
end
