#coding: utf-8

class PokeMailer < ActionMailer::Base
  default from: "Panela de Pressão <contato@paneladepressao.org.br>"
  layout 'mailer'

  def poke(the_poke)
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"poke\"] }"
    @poke = the_poke
    mail(
      :to => @poke.campaign.influencers.map{|i| "'#{i.name}' <#{i.email}>" if i.email.present? }.join(", "),
      :subject => @poke.campaign.name,
      :from => "\"#{@poke.user.name}\" <#{@poke.user.email}>",
      :reply_to => @poke.user.email
    )
  end

  def thanks(the_poke)
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"thanks_for_your_poke\"] }"
    @poke = the_poke
    @campaign = @poke.campaign
    @organization = @poke.campaign.organization if @poke.campaign.moderated?
    mail(
      :to => @poke.user.email,
      :subject => "Obrigado por pressionar",
      :from => "#{@poke.campaign.user.name} <#{@poke.campaign.user.email}>")
  end

  def facebook_client_error(target, poke)
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"facebook_client_error\"] }"
    @influencer = target.influencer
    @campaign = target.campaign
    @poker = poke.user

    mail(
      :to => User.where(admin: true).map{|u| u.email},
      :subject => "Não foi possível postar em página do Facebook"
    )
  end
end
