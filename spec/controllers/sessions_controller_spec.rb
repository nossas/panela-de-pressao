require 'spec_helper'

describe SessionsController do
  subject{ response }

  describe "GET /auth/facebook/callback" do
    before do
      OmniAuth.config.add_mock(:facebook, {:uid => '12345'})
      request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook] 
      get :create, :provider => 'facebook'
    end
    it{ should redirect_to root_path }
  end

end
