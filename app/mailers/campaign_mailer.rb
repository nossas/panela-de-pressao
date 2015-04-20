# coding: utf-8
#
class CampaignMailer < ActionMailer::Base
  default from: "Panela de Pressão <contato@paneladepressao.org.br>"
  layout 'mailer'

  def we_received_your_campaign campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"we_received_your_campaign\"] }"
    @campaign = campaign
    @organization = @campaign.organization
    from = @organization.pdp_sender_email.present? ? @organization.pdp_sender_email : "João Mauro do Meu Rio <contato@meurio.org.br>"
    mail(to: campaign.user.email, subject: "A sua mobilização está no ar!", from: from)
  end

  def new_campaign campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"new_campaign\"] }"
    @campaign = campaign
    @organization = @campaign.organization
    to = @organization.pdp_receiver_email.present? ? @organization.pdp_receiver_email : "curadoria@paneladepressao.org.br"
    mail(to: to, subject: "Nova campanha no Panela de Pressão (#{@organization.city})")
  end
end
