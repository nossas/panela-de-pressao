require 'spec_helper'

describe Poke do
  before do
    bitly = Bitly.new('bitly id', 'bitly key')
    bitly.stub_chain(:shorten, :short_url).and_return("http://localhost:3000/campaigns")
    Bitly.stub(:new).and_return(bitly)
  end

  describe "#twitter?" do
    context "when kind is other than twitter" do
      subject{ Poke.new(:kind => 'email').twitter? }
      it{ should be_false }
    end

    context "when kind is twitter" do
      subject{ Poke.new(:kind => 'twitter').twitter? }
      it{ should be_true }
    end
  end

  describe "#email?" do
    context "when kind is other than email" do
      subject{ Poke.new(:kind => 'twitter').email? }
      it{ should be_false }
    end

    context "when kind is email" do
      subject{ Poke.new(:kind => 'email').email? }
      it{ should be_true }
    end
  end


  describe "#poked_recently" do
    context "When the user hasn't poked yet" do
      it "No error should be thrown" do
        expect(subject).to have(0).error_on(:created_at)
      end
    end
    context "When the user has poked the same channel in less than 1 day" do
      let(:campaign)  { Campaign.make! }
      let(:user)      { User.make! }
      before          { campaign.influencers << Influencer.make! }
      before          { Poke.make!(created_at: Time.now - 23.hours, kind: "facebook", campaign: campaign, user: user) }

      it "Should not throw an error saying 'you poked this channel recently' when it's another channel in another time window" do
        new_poke = Poke.create(user_id: user.id, campaign_id: campaign.id, kind: "email")
        expect(new_poke).to have(0).error_on(:created_at)
      end

      it "Should throw an error saying 'you poked this channel recently' when the user already poked the same channel some minutes ago" do
        new_poke = Poke.create(user_id: user.id, campaign_id: campaign.id, kind: "facebook")
        expect(new_poke).to have(1).error_on(:created_at)
        expect(new_poke.errors[:created_at]).to eq([I18n.t("activerecord.errors.models.poke.attributes.created_at.poked_recently")])
      end

      it "Should not throw an error when the user hasn't any recent pokes in the same channel" do
        new_poke = Poke.make(created_at: Time.now, user_id: user.id, campaign_id: campaign.id, kind: "facebook")
        expect(new_poke).to have(0).error_on(:created_at)
      end
    end
  end

  describe "#first?" do
    context "when the user never poked this campaign" do
      before { subject.stub(:campaign_id).and_return(1) }
      before { subject.stub(:user_id).and_return(1) }
      before { Poke.stub(:where).with(:user_id => 1, :campaign_id => 1).and_return([subject]) }
      its(:first?){ should be_true }
    end
    
    context "when the user already poked this campaign" do
      before { subject.stub(:campaign_id).and_return(1) }
      before { subject.stub(:user_id).and_return(1) }
      before { Poke.stub(:where).with(:user_id => 1, :campaign_id => 1).and_return([stub_model(Poke), subject]) }
      its(:first?){ should be_false }
    end
  end

end
