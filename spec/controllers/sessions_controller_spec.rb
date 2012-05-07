require 'spec_helper'

describe SessionsController do
  subject{ response }

  describe "GET /auth/facebook/callback" do
    let(:poke) { { :user_id => user.id.to_s, :kind => 'email', :campaign_id => Campaign.make!.id } }
    let(:user) { User.make! }
    before do
      OmniAuth.config.add_mock(:facebook, {:uid => '12345'})
      Authorization.stub(:create_from_hash).and_return(stub_model(Authorization, :user => user))
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
    end

    context "with poke but no twitter auth" do
      before do
        session[:poke] = poke
        get :create, :provider => 'facebook'
      end
      it{ should redirect_to '/auth/twitter' }
    end

    context "with poke and twitter auth" do
      before do
        Authorization.make! :provider => 'twitter', :user => user
        session[:poke] = poke
        get :create, :provider => 'facebook'
      end
      it{ should redirect_to create_from_session_campaign_pokes_path(:campaign_id => poke[:campaign_id]) }
    end

    context "without poke" do
      before do
        get :create, :provider => 'facebook'
      end
      it{ should redirect_to root_path }
    end
  end

end
