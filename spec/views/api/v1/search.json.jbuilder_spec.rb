require "spec_helper"

describe "api/v1/influencers/search.json.jbuilder", type: :view do
  context "when the search returns a influencer" do
    before do
      @influencer = Influencer.make! name: "George Michael Bluth"
      assign(:documents, PgSearch.multisearch("George Michael Bluth"))
      render
      @json = JSON.parse(rendered)[0]
    end

    it "should have the searchable type" do
      expect(@json["searchable_type"]).to be_eql("Influencer")
    end

    it "should have the searchable id" do
      expect(@json["searchable"]["id"]).to be_eql(@influencer.id)
    end

    it "should have the searchable name" do
      expect(@json["searchable"]["name"]).to be_eql(@influencer.name)
    end

    it "should have the searchable role" do
      expect(@json["searchable"]["role"]).to be_eql(@influencer.role)
    end

    it "should have the searchable html" do
      expect(@json["searchable"]["html"]).to be_eql(render(partial: 'influencers/influencer_field.html', locals: { influencer: @influencer }))
    end
  end

  context "when the search returns a influencers group" do
    before do
      @group = InfluencersGroup.make! name: "Bluth Family"
      @group.influencers << Influencer.make!
      assign(:documents, PgSearch.multisearch("Bluth Family"))
      render
      @json = JSON.parse(rendered)[0]
    end

    it "should have the searchable type" do
      expect(@json["searchable_type"]).to be_eql("InfluencersGroup")
    end

    it "should have the searchable id" do
      expect(@json["searchable"]["id"]).to be_eql(@group.id)
    end

    it "should have the searchable name" do
      expect(@json["searchable"]["name"]).to be_eql(@group.name)
    end

    it "should have the searchable html" do
      expect(@json["searchable"]["html"]).to be_eql(render(partial: 'influencers/influencer_field.html', collection: @group.influencers, as: :influencer))
    end
  end
end
