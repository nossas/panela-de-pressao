require 'spec_helper'

describe User do
  it { should have_many :authorizations }
  it { should have_many :campaigns }

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
