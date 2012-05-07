require 'spec_helper'

describe SessionsController do
  subject{ response }

  describe "GET /auth/facebook/callback" do
    let(:poke) { { :user_id => User.make!.id.to_s, :kind => 'email', :campaign_id => Campaign.make!.id } }
    before do
      OmniAuth.config.add_mock(:facebook, {:uid => '12345'})
      Authorization.stub(:create_from_hash).and_return(stub_model(Authorization, :user => stub_model(User, :id => 12345)))
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
    end

    context "with poke" do
      before do
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
