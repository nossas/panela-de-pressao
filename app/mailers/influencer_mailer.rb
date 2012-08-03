#coding: utf-8

class InfluencerMailer < ActionMailer::Base
  default from: I18n.t('emails.contact')

  def created(influencer)
    @influencer = influencer

    mail(
      to:       I18n.t('emails.trusteeship'),
      subject:  I18n.t('emails.influencer.subject.created'),
      from:     I18n.t('emails.contact') 
    )
  end

  def edited(influencer)
    @influencer = influencer

    mail(
      to:       I18n.t('emails.trusteeship'),
      subject:  I18n.t('emails.influencer.subject.edited', target: influencer.name),
      from:     I18n.t('emails.contact')
    )
  end
end

