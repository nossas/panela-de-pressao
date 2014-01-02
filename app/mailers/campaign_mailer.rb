# coding: utf-8
#
class CampaignMailer < ActionMailer::Base
  default from: "Panela de Pressão <contato@paneladepressao.org.br>"
  layout 'mailer'

  def campaign_accepted campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"campaign_accepted\"] }"
    @campaign = campaign
    mail(to: campaign.user.email, subject: "Sua campanha foi aprovada!")
  end

  def campaign_awaiting_moderation campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"campaign_awaiting_moderation\"] }"
    @campaign = campaign
    mail(to: "curadoria@paneladepressao.org.br", subject: "Campanha aguardando moderação")
  end
  
  def campaigns_without_moderator
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"campaigns_without_moderator\"] }"
    @campaigns = Campaign.orphan.unmoderated.unarchived
    mail(to: "curadoria@paneladepressao.org.br", subject: "Campanhas sem moderador")
  end

  def we_received_your_campaign campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"we_received_your_campaign\"] }"
    @campaign = campaign
    mail(to: campaign.user.email, subject: "A sua mobilização está no ar!", from: "Fernanda do Meu Rio <contato@meurio.org.br>")
  end

  def report campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"campaign_report\"] }"
    @campaign = campaign
    mail(to: campaign.user.email, subject: "Relatório da sua campanha")
  end
end
