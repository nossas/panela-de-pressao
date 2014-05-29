# coding: utf-8
#
class CampaignMailer < ActionMailer::Base
  default from: "Panela de Pressão <contato@paneladepressao.org.br>"
  layout 'mailer'

  def we_received_your_campaign campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"we_received_your_campaign\"] }"
    @campaign = campaign
    @organization = @campaign.organization
    mail(to: campaign.user.email, subject: "A sua mobilização está no ar!", from: "Fernanda do Meu Rio <contato@meurio.org.br>")
  end

  def new_campaign campaign
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"new_campaign\"] }"
    @campaign = campaign
    mail(to: "curadoria@paneladepressao.org.br", subject: "Nova campanha")
  end
end
