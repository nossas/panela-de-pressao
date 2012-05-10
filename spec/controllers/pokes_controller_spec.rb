require 'spec_helper'

describe PokesController do
  subject{ response }

  describe "GET create_from_session" do
    let(:user) { User.make! }
    let(:campaign) { Campaign.make! }
    let(:poke) { { "user_id" => user.id.to_s, "kind" => 'email', "campaign_id" => campaign.id.to_s } }

    context "when I'm logged in and have a poke in session" do
      before do
        session[:poke] = poke
        controller.stub(:current_user).and_return(user)
        get :create_from_session, :campaign_id => campaign.id
      end

      it{ should redirect_to campaign_path(Campaign.last) }
      it{ session[:poke].should == nil }
    end

    context "when I'm logged in and have no poke in session" do
      before do
        controller.stub(:current_user).and_return(User.make!)
        post :create, :poke => poke, :campaign_id => campaign.id
      end

      it{ should redirect_to campaign_path(Campaign.last) }
      it{ session[:poke].should == nil }
    end

    context "when I'm not logged in" do
      before do
        post :create, :poke => poke, :campaign_id => campaign.id
      end

      it{ should redirect_to new_session_path }
      it{ session[:poke].should == poke }
    end
  end

  describe "POST create" do
    context "when it's a Twitter poke" do
      context "when the current user have a Twitter authorization" do
        before do
          controller.stub(:current_user).and_return(mock_model(User, :twitter_authorization => mock_model(Authorization)))
          post :create
        end
      end
      context "when the current user doesn't have a Twitter authorization" do
      end
      context "when there is no current user" do
      end
    end
  end

end
