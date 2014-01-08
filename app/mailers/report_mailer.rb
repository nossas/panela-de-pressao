# coding: utf-8

class ReportMailer < ActionMailer::Base
  default from: "Panela de Pressão <contato@paneladepressao.org.br>"

  def new_report report
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"new_report\"] }"
    @report = report
    mail(:to => "curadoria@paneladepressao.org.br", :subject => "Nova denúncia")
  end
end
