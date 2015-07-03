# coding: utf-8
require 'spec_helper'

describe PokesController, type: :controller do
  before do
    bitly = Bitly.new('bitly id', 'bitly key')
    bitly.stub_chain(:shorten, :short_url).and_return("http://localhost:3000/campaigns")
    Bitly.stub(:new).and_return(bitly)
  end

  describe "POST create" do
    let(:campaign) { Campaign.make! }

    context "when it's logged in" do
      before { controller.stub(:current_user).and_return(User.make!) }

      context "when it's an email poke" do
        before { Poke.any_instance.stub(:save) }
        it "should create a new poke" do
          Poke.any_instance.should_receive(:save)
          post :create, :poke => {:kind => "email"}, :campaign_id => campaign.id
        end
        it "should redirect to campaign page" do
          post :create, :poke => {:kind => "email"}, :campaign_id => campaign.id
          should redirect_to "/campaigns/#{campaign.id}?success=true"
        end
      end

      context "when it's a Twitter poke" do
        before { controller.stub(:require_twitter_auth) }
        before { Poke.any_instance.stub(:save) }
        it "should create a new poke" do
          Poke.any_instance.should_receive(:save)
          post :create, :poke => {:kind => "twitter"}, :campaign_id => campaign.id
        end
        it "should verify twitter authorization" do
          controller.should_receive(:require_twitter_auth)
          post :create, :poke => {:kind => "twitter"}, :campaign_id => campaign.id
        end
        it "should redirect to campaign page" do
          post :create, :poke => {:kind => "twitter"}, :campaign_id => campaign.id
          should redirect_to "/campaigns/#{campaign.id}?success=true"
        end
      end

      context "when it's a Facebook poke" do
        before { controller.stub(:require_facebook_auth) }
        before { Poke.any_instance.stub(:save) }
        it "should create a new poke" do
          Poke.any_instance.should_receive(:save)
          post :create, :poke => {:kind => "facebook"}, :campaign_id => campaign.id
        end
        it "should verify facebook authorization" do
          controller.should_receive(:require_facebook_auth)
          post :create, :poke => {:kind => "facebook"}, :campaign_id => campaign.id
        end
        it "should redirect to campaign page" do
          post :create, :poke => {:kind => "facebook"}, :campaign_id => campaign.id
          should redirect_to "/campaigns/#{campaign.id}?success=true"
        end
      end
    end

    # Disable Twitter poke
    # context "when it's not logged in" do
    #   before { @request.env['HTTP_REFERER'] = 'http://test.com/' }
    #   before { post :create, :poke => {:kind => "twitter"}, :campaign_id => "1" }
    #   it { should redirect_to(ENV["MEURIO_ACCOUNTS_URL"] + "?redirect_url=#{session[:restore_url]}") }
    # end
  end

  describe "GET index" do
    let (:campaign) { Campaign.make! }

    context "when the token is provided" do
      before { get :index, token: ENV["API_TOKEN"], format: :json, campaign_id: campaign.id }
      its(:status) { should be_== 200 }
    end
    context "when the token is not provided" do
      before { get :index, format: :json, campaign_id: campaign.id }
      its(:status) { should be_== 302 }
    end
  end
end
