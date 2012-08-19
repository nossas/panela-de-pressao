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
      let(:poke) { Poke.make!(created_at: Time.now - 10.minutes) }
      subject { Poke.create(created_at: Time.now, user_id: poke.user.id, campaign_id: poke.campaign.id, kind: "facebook") }

      it "Should throw an error saying 'you poked this channel recently'" do
        expect(subject).to have(1).error_on(:created_at)
        expect(subject.errors[:created_at]).to eq([I18n.t("activerecord.errors.models.poke.attributes.created_at.poked_recently")])
      end
    end
  end

end
