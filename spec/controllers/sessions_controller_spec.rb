require 'spec_helper'

describe SessionsController do
  subject{ response }

  before do
    bitly = Bitly.new('bitly id', 'bitly key')
    bitly.stub_chain(:shorten, :short_url).and_return("http://localhost:3000/campaigns")
    Bitly.stub(:new).and_return(bitly)
  end

  describe "GET /auth/facebook/callback" do
    let(:poke) { { :user_id => user.id.to_s, :kind => 'email', :campaign_id => Campaign.make!.id } }
    let(:user) { User.make! }
    before do
      OmniAuth.config.add_mock(:facebook, {:uid => '12345'})
      Authorization.stub(:create_from_hash).and_return(stub_model(Authorization, :user => user))
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
    end

    context "with poke" do
      before do
        session[:poke] = poke
        get :create, :provider => 'facebook'
      end
      it{ should redirect_to create_from_session_campaign_pokes_path(:campaign_id => poke[:campaign_id], :user_id => user.id) }
    end

    context "without poke" do
      before do
        get :create, :provider => 'facebook'
      end
      it{ should redirect_to root_path }
    end
  end

end
