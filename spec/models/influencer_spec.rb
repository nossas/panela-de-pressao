require 'spec_helper'

describe Influencer do
  describe "associations" do
    it { should have_many :targets }
    it { should have_many :campaigns }

    it "should have and belongs to many influencers groups" do
      group = InfluencersGroup.make!
      influencer = Influencer.make!
      group.influencers << influencer
      expect(influencer.influencers_groups).to include(group)
    end
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :role }
  end

	describe "#archive" do
	  subject { Influencer.make! }
    before do
      @time = Time.now
      allow(Time).to receive(:now).and_return(@time)
    end

    context "when it is not archived" do
      before { subject.archived_at = nil }

      it "should archive the campaign" do
        expect{ subject.archive }.to change{ subject.archived_at }.from(nil).to(@time)
      end
    end

    context "when it is archived" do
      before { subject.archived_at = Time.now }

      it "should unarchive the campaign" do
        expect{ subject.archive }.to change{ subject.archived_at }.from(@time).to(nil)
      end
    end
  end

  describe "#archived?" do
    subject { Influencer.make! }

    context "when it is not archived" do
      before { subject.archived_at = nil }

      it "should be false" do
        expect(subject.archived?).to be_falsey
      end
    end

    context "when it is archived" do
      before { subject.archived_at = Time.now }

      it "should unarchive the campaign" do
        expect(subject.archive).to be_truthy
      end
    end
  end

  describe ".available" do
    let(:influencer1) { Influencer.make! }
    let(:influencer2) { Influencer.make!(archived_at: Time.now) }

    subject { Influencer.available }
    it { should include(influencer1) }
    it { should_not include(influencer2) }
  end

  describe "#set_facebook_id" do
    context "when the Facebook url is https://www.facebook.com/pages/Deputado-Adilson-Rossi/244989718849989" do
      subject { Influencer.make! facebook_url: "https://www.facebook.com/pages/Deputado-Adilson-Rossi/244989718849989" }
      its(:facebook_id){ should be_eql "244989718849989" }
    end

    context "when the Facebook url is https://www.facebook.com/adrianodiogopt" do
      subject { Influencer.make! facebook_url: "https://www.facebook.com/adrianodiogopt" }
      its(:facebook_id){ should be_eql "adrianodiogopt" }
    end

    context "when the Facebook url is facebook.com/BrinquedosEstrela" do
      subject { Influencer.make! facebook_url: "facebook.com/BrinquedosEstrela" }
      its(:facebook_id){ should be_eql "BrinquedosEstrela" }
    end

    context "when the Facebook url is blank" do
      subject { Influencer.make! facebook_url: "", facebook_id: nil }
      its(:facebook_id){ should be_nil }
    end
  end
end
