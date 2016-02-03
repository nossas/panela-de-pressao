# coding: utf-8

class ReportMailer < ActionMailer::Base
  default from: "Panela de Pressão <pdp@meurio.org.br>"
  layout 'mailer'

  def new_report report
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"new_report\"] }"
    @report = report
    @organization = report.campaign.organization
    to = @organization.pdp_receiver_email.present? ? @organization.pdp_receiver_email : "pdp@meurio.org.br"
    mail(:to => to, :subject => "Nova denúncia no Panela (#{@organization.city})")
  end
end
