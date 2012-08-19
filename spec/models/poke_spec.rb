require 'spec_helper'

describe Poke do
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
    context "When the user has poked the same channel in less than 15 minutes" do
      let(:poke) { Poke.make!(created_at: Time.now - 10.minutes, kind: "facebook") }

      it "Should not throw an error saying 'you poked this channel recently' when it's another channel in another time window" do
        new_poke = Poke.create(user_id: poke.user.id, campaign_id: poke.campaign.id, kind: "email")
        expect(new_poke).to have(0).error_on(:created_at)
      end

      it "Should throw an error saying 'you poked this channel recently' when the user already poked the same channel some minutes ago" do
        new_poke = Poke.create(user_id: poke.user.id, campaign_id: poke.campaign.id, kind: "facebook")
        expect(new_poke).to have(1).error_on(:created_at)
        expect(new_poke.errors[:created_at]).to eq([I18n.t("activerecord.errors.models.poke.attributes.created_at.poked_recently")])
      end

      it "Should not throw an error when the user hasn't any recent pokes in the same channel" do

        new_poke = Poke.make(created_at: Time.now + 6.minutes, user_id: poke.user.id, campaign_id: poke.campaign.id, kind: "facebook")
        expect(new_poke).to have(0).error_on(:created_at)
      end
    end
  end

end
