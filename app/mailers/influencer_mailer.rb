#coding: utf-8

class InfluencerMailer < ActionMailer::Base
  default from: "Panela de Pressão <contato@paneladepressao.org.br>"
  layout 'mailer'

  def facebook_was_not_updated(influencer, user_id, facebook_url)
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"influencer_facebook_was_not_updated\"] }"
    @influencer = influencer
    @user = User.find user_id
    @facebook_url = facebook_url
    mail(:to => @user.email, :subject => "O perfil do #{@influencer.name} não foi atualizado")
  end
end

