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
      :from => "\"#{@poke.user.name}\" <#{@poke.user.email}>"
    )
  end

  def thanks(the_poke)
    headers "X-SMTPAPI" => "{ \"category\": [\"pdp\", \"thanks_for_your_poke\"] }"
    @poke = the_poke
    mail(:to => @poke.user.email, :subject => "Valeu por apoiar a campanha: #{@poke.campaign.name}")
  end
end
