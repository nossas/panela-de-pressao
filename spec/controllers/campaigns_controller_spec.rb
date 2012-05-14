# coding: utf-8
require 'spec_helper'

describe CampaignsController do
  describe "POST create" do
    before do 
      controller.stub(:current_user).and_return(stub_model(User))
      bitly = Bitly.new(ENV['BITLY_ID'], ENV['BITLY_SECRET'])
      Campaign.any_instance.stub(:save)
      bitly.should_receive(:shorten).with(Rails.application.routes.url_helpers.campaign_url(1)).and_return(mock_model(Campaign, :short_url => 'short_url'))
      campaign = stub_model(Campaign, :id => 1)
      campaign.should_receive(:update_attribute).with(:short_url, 'short_url')
      controller.stub(:resource).and_return(campaign)
      Bitly.should_receive(:new).with(ENV['BITLY_ID'], ENV['BITLY_SECRET']).and_return(bitly)
      post :create, :campaign => {}
    end
    it { should redirect_to campaigns_path }
    it { should set_the_flash.to "Aí! Recebemos a sua campanha. Em breve entraremos em contato para colocá-la no ar..." }
  end

  describe "GET show" do
    before do 
      Campaign.stub(:find).and_return(stub_model(Campaign, :accepted_at => Time.now))
      get :show, :id => "1"
    end
    it { should assign_to(:poke) }
  end

  describe "PUT accept" do
    before { Campaign.stub(:find).and_return(mock_model(Campaign, :update_attribute => true)) }
    context "when I'm admin" do
      before { controller.stub(:current_user).and_return(mock_model(User, :admin? => true)) }
      before { put :accept, :campaign_id => "1" }
      it { should_not redirect_to(new_session_path) }
    end
    context "when I'm not admin" do
      before { controller.stub(:current_user).and_return(mock_model(User, :admin? => false)) }
      before { put :accept, :campaign_id => "1" }
      it { should redirect_to(new_session_path) }
    end
  end
end
