require 'spec_helper'

RSpec.describe ErrorsController, :type => :controller do
  describe "GET not_found" do
    it "should render status 404" do
      get :not_found
      expect(response.status).to eq(404)
    end
  end
end
