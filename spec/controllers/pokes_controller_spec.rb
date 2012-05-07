require 'spec_helper'

describe PokesController do
  subject{ response }

  describe "GET create_from_session" do
    let(:user) { User.make! }
    let(:poke) { { 'user_id' => user.id, 'kind' => 'email' } }
    let(:campaign) { Campaign.make! }

    context "when I'm logged in and have a poke in session" do
      before do
        session[:poke] = poke
        controller.stub(:current_user).and_return(user)
        get :create_from_session, :campaign_id => campaign.id
      end

      it{ should redirect_to campaign_path(Campaign.last) }
      it{ session[:poke].should == nil }
      it{ controller.params[:poke].should == poke }
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
      it{ session[:poke].should == poke.merge('user_id' => poke['user_id'].to_s, 'campaign_id' => campaign.id.to_s) }
    end
  end

end
