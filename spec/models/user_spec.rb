require 'spec_helper'

describe User do
  it { should have_many :authorizations }
  it { should have_many :campaigns }

  describe "#can_poke?" do
    subject { User.make! }
    let(:campaign) { Campaign.make! }

    context "when there is no poke in the last 24h" do
      it("should be true") { subject.can_poke?(campaign).should be_true }
    end

    context "when there is at least one poke in the last 24h" do
      before { Target.make! campaign: campaign }
      before { Poke.make! user: subject, campaign: campaign }
      it("should be false") { subject.can_poke?(campaign).should be_false }
    end
  end

  describe ".by_campaign_id" do
    let(:user)      { User.make! }
    let(:campaign)  { Campaign.make! }
    before          { campaign.influencers << Influencer.make! }
    before          { Poke.make!(campaign: campaign, user: user) }
    subject         { User.by_campaign_id(campaign.id) }

    it "should return a list of users that poked a given campaign" do
      subject.should == [user]
    end
  end
end
