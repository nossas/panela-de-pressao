require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many :authorizations }
    it { should have_many :campaigns }
  end
  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :name }
  end

  describe "#pic" do
    before { subject.stub_chain(:file, :large, :url).and_return(nil) }
    context "when the user uploaded a picture" do
      before { subject.stub_chain(:file, :large, :url).and_return("profile.jpg") }
      its(:pic){ should be_== "profile.jpg" }
    end
    context "when the user have a picture from somewhere" do
      before { subject.stub(:picture).and_return("picture.jpg") }
      its(:pic){ should be_== "picture.jpg" }
    end
  end

  describe "#can_poke?" do
    let(:campaign) { stub_model(Campaign, :id => 1) }
    it("should be able to poke a campaign that he never poked") { subject.can_poke?(campaign).should be_true }
    context "when the user has poked with Facebook in less than 24 hours ago" do
      before { subject.stub_chain(:pokes, :where).and_return([stub_model(Poke, :type => "facebook", :created_at => Time.now)]) }
      it("should not be able to poke with Facebook") { subject.can_poke?(campaign, :with => "facebook").should_not be_true }
      it("should be able to poke with Twitter") { subject.can_poke?(campaign, :with => "twitter").should_not be_true }
      it("should be able to poke with Email") { subject.can_poke?(campaign, :with => "email").should_not be_true }
    end
  end
  


  describe ".by_campaign_id" do
    let(:user) { User.make! }
    let(:campaign) { Campaign.make! }
    before do
      Poke.make!(campaign: campaign, user: user) 
    end
    subject { User.by_campaign_id(campaign.id) }

    it "should return a list of users that poked a given campaign" do
      subject.should == [user]
    end
  end
end
