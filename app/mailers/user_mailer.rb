# coding: utf-8

class UserMailer < ActionMailer::Base
  layout 'mailer'

  def recomendations(user_id)
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"recomendations\"] }"
    @user = User.find user_id
    @recomendations = Recomendation.where(:user_id => @user.id).order("RANDOM()").limit(3)

    mail(
      :to => @user.email,
      :subject => "Veja as campanhas que separamos essa semana para você",
      :from => "contato@paneladepressao.org.br"
    )
  end
end
