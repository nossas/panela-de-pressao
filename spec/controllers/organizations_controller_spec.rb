require 'spec_helper'

describe OrganizationsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      controller.stub(:current_user).and_return(stub_model(User))
      get 'new'
      response.should be_success
    end
  end

end
