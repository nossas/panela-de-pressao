# coding: utf-8
require 'spec_helper'

describe CampaignsController, type: :controller do
  describe "GET show" do
    context "All campaigns" do
      before do
        allow(Campaign).to receive(:find_by_id).and_return(Campaign.make!)
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
