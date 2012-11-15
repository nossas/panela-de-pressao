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
    before { Campaign.stub(:find).and_return(mock_model(Campaign, :update_attribute => true, :accept_now! => true)) }
    context "when I'm admin" do
      before { controller.stub(:current_user).and_return(mock_model(User, :admin? => true)) }
      before { put :accept, :campaign_id => "1" }
      it { should_not redirect_to(campaigns_path + "#login") }
    end
    context "when I'm not admin" do
      before { controller.stub(:current_user).and_return(mock_model(User, :admin? => false)) }
      before { @request.env['HTTP_REFERER'] = 'http://test.com/' }
      before { put :accept, :campaign_id => "1" }
      it { should redirect_to("/auth/facebook") }
    end
  end
end
