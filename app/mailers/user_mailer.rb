# coding: utf-8

class UserMailer < ActionMailer::Base
  default from: "Panela de Pressão <contato@paneladepressao.org.br>"
  layout 'mailer'

  def recomendations(user_id)
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"recomendations\"] }"
    @user = User.find user_id
    @recomendations = @user.recomendations.order("RANDOM()").limit(3)
    mail(:to => @user.email, :subject => "Veja as campanhas que separamos essa semana para você")
  end
end
