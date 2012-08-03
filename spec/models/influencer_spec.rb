require 'spec_helper'

describe Influencer do
  describe "associations" do
    it { should have_many :targets }
    it { should have_many :campaigns }
  end
  describe "validations" do 
    it { should validate_presence_of :name }
    it { should validate_presence_of :role }
  end


  describe "Fire email on influencer create/edit" do
    before do 
      @influencer = Influencer.make!
    end

    it "should fire a 'new influencer' email when a new influencer is created" do
      ActionMailer::Base.deliveries.last.subject.should be_== I18n.t('emails.influencer.subject.created')  
    end
    
    it "should fire a 'influencer was edited' e-mail when a existing influencer is edited" do
      @influencer.update_attribute(:email, "new_email@iamkidding.com")
      ActionMailer::Base.deliveries.last.subject.should be_== I18n.t('emails.influencer.subject.edited', target: @influencer.name)  
    end
  end
end
