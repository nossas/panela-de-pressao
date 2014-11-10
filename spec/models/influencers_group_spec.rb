require 'spec_helper'

RSpec.describe InfluencersGroup, :type => :model do
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  it "should have and belongs to many influencers" do
    group = InfluencersGroup.make!
    influencer = Influencer.make!
    influencer.influencers_groups << group
    expect(group.influencers).to include(influencer)
  end
end
