require 'spec_helper'

describe Campaign do
  describe "associations" do
    it{ should belong_to :user }
    it{ should belong_to :organization }
    it{ should belong_to :category }
    it{ should have_many :posts }
    it{ should have_many :pokes }
    it{ should have_many :influencers }
  end

  describe "validations" do
    it{ should validate_presence_of :name }
    it{ should validate_presence_of :description }
    it{ should validate_presence_of :user_id }
    it{ should validate_presence_of :image }
    it{ should validate_presence_of :category }
  end

  describe "#pokers" do
    context "when there is no poke" do
      its(:pokers) { should be_empty }
    end
    context "when there is one poke" do
      let(:poker) { mock_model(User) }
      before { subject.stub(:pokes).and_return([mock_model(Poke, :user => poker)]) }
      its(:pokers) { should be_== [poker] }
    end
    context "when there is two pokes of the same guy" do
      let(:poker) { mock_model(User) }
      before { subject.stub(:pokes).and_return([mock_model(Poke, :user => poker), mock_model(Poke, :user => poker)]) }
      its(:pokers) { should be_== [poker] }
    end
  end
end
