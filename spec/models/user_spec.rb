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
    context "when the user have a picture from Facebook" do
      before { subject.stub(:facebook_pic).and_return("facebook.jpg") }
      its(:pic){ should be_== "facebook.jpg" }
    end
    context "when the user have a picture from somewhere" do
      before { subject.stub(:picture).and_return("picture.jpg") }
      its(:pic){ should be_== "picture.jpg" }
    end
    context "when the user have no picture at all" do
      its(:pic){ should be_== "http://meurio.org.br/assets/avatar_blank.png" }
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

end
