# coding: utf-8
require 'spec_helper'

describe CampaignsController do
  describe "POST create" do
    before do 
      controller.stub(:current_user).and_return(stub_model(User))
      bitly = Bitly.new(ENV['BITLY_ID'], ENV['BITLY_SECRET'])
      Campaign.any_instance.stub(:save)
      campaign = stub_model(Campaign, :id => 1)
      controller.stub(:resource).and_return(campaign)
      post :create, :campaign => {}
    end
    it { should redirect_to campaigns_path }
  end

  describe "GET show" do
    context "All campaigns" do
      before do 
        Campaign.stub(:find).and_return(stub_model(Campaign))
        get :show, :id => "1"
      end
      its(:status) { should == 200 }
    end
  end

  describe "GET index" do
    context "when the token is provided" do
      before { get :index, token: ENV["API_TOKEN"], format: :json }
      its(:status) { should be_== 200 }
    end
    context "when the token is not provided" do
      before { get :index, format: :json }
      its(:status) { should be_== 302 }
    end
  end
end
