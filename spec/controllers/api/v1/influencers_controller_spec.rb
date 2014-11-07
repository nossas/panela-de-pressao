require 'spec_helper'

describe Api::V1::InfluencersController, type: :controller do
  describe "GET search" do
    before { @influencer = Influencer.make! name: "George Michael Bluth" }

    it "should assign @documents" do
      get :search, q: "George Michael Bluth", format: :json
      expect(assigns(:documents)).to eq(PgSearch.multisearch("George Michael Bluth"))
    end

    it "should render the search template" do
      get :search, q: "George Michael Bluth", format: :json
      expect(response).to render_template("search")
    end
  end
end
