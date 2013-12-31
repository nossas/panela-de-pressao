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
    it { should set_the_flash.to "Está valendo, campanha no ar!" }
  end

  describe "GET show" do
    context "Accepted campaigns" do
      before do 
        Campaign.stub(:find).and_return(stub_model(Campaign, :accepted_at => Time.now))
        get :show, :id => "1"
      end
      its(:status) { should == 200 }
    end

    context "Not accepted campaigns with a wrong preview code" do
      before do 
        Campaign.stub(:find).and_return(stub_model(Campaign, :accepted_at => nil, preview_code: 12345))
        get :show, id: 1, preview_code: 1234
      end
      it { should redirect_to(ENV["MEURIO_ACCOUNTS_URL"] + "?redirect_url=#{session[:restore_url]}") }
    end

    context "Not accepted campaigns with a correct preview code" do
      before do 
        Campaign.stub(:find).and_return(stub_model(Campaign, :accepted_at => nil, preview_code: "12345"))
        get :show, id: 1, preview_code: 12345
      end

      it { should_not redirect_to("http://127.0.0.1/meurio_accounts") }
    end

      
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
      it { should redirect_to(ENV["MEURIO_ACCOUNTS_URL"] + "?redirect_url=#{session[:restore_url]}") }
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
