#coding: utf-8

class InfluencerMailer < ActionMailer::Base
  def facebook_was_not_updated(influencer, user_id, facebook_url)
    @influencer = influencer
    @user = User.find user_id
    @facebook_url = facebook_url

    mail(
      :to => @user.email,
      :subject => "O perfil do #{@influencer.name} não foi atualizado",
      :from => "contato@paneladepressao.org.br"
    )
  end
end

