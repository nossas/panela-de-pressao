# coding: utf-8
require 'spec_helper'

describe PokesController do
  before { Campaign.stub(:find).with("1").and_return(mock_model(Campaign, :id => 1, :pokes => double(Object, :build => Poke.new))) }

  describe "POST create" do

    context "when it's logged in" do
      before { controller.stub(:current_user).and_return(stub_model(User)) }
      
      context "when it's an email poke" do
        before { Poke.any_instance.stub(:save) }
        it "should create a new poke" do
          Poke.any_instance.should_receive(:save)
          post :create, :poke => {:kind => "email"}, :campaign_id => "1"
        end
        it "should redirect to campaign page" do
          post :create, :poke => {:kind => "email"}, :campaign_id => "1"
          should redirect_to "/campaigns/1#congrats"
        end
      end

      context "when it's a Twitter poke" do
        before { controller.stub(:require_twitter_auth) }
        before { Poke.any_instance.stub(:save) }
        it "should create a new poke" do
          Poke.any_instance.should_receive(:save)
          post :create, :poke => {:kind => "twitter"}, :campaign_id => "1"
        end
        it "should verify twitter authorization" do
          controller.should_receive(:require_twitter_auth)
          post :create, :poke => {:kind => "twitter"}, :campaign_id => "1"
        end
        it "should redirect to campaign page" do
          post :create, :poke => {:kind => "twitter"}, :campaign_id => "1"
          should redirect_to "/campaigns/1#congrats"
        end
      end

      context "when it's a Facebook poke" do
        before { controller.stub(:require_facebook_auth) }
        before { Poke.any_instance.stub(:save) }
        it "should create a new poke" do
          Poke.any_instance.should_receive(:save)
          post :create, :poke => {:kind => "facebook"}, :campaign_id => "1"
        end
        it "should verify facebook authorization" do
          controller.should_receive(:require_facebook_auth)
          post :create, :poke => {:kind => "facebook"}, :campaign_id => "1"
        end
        it "should redirect to campaign page" do
          post :create, :poke => {:kind => "facebook"}, :campaign_id => "1"
          should redirect_to "/campaigns/1#congrats"
        end
      end
    end

    context "when it's not logged in" do
      before { @request.env['HTTP_REFERER'] = 'http://test.com/' }
      before { post :create, :poke => {:kind => "twitter"}, :campaign_id => "1" }
      it { should redirect_to("http://test.com/#login") }
    end

  end
end
