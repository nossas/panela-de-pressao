class PokeMailerPreview < ActionMailer::Preview
  def facebook_client_error
    target = Target.first
    poke = Poke.first
    target.influencer.update_attribute :facebook_url, "https://www.facebook.com/meurio"
    PokeMailer.facebook_client_error(target, poke)
  end
end
