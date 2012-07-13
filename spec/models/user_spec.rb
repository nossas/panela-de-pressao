require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many :authorizations }
    it { should have_many :campaigns }
    it { should have_many :organizations }
  end
  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :name }
  end


  describe "#picture" do
    context "When the user is logged in through facebook" do
      let(:user) { Authorization.make!(provider: "facebook", uid: "01").user }
      it "should return its large picture url" do
        user.picture.should be_== "http://graph.facebook.com/01/picture?type=large"
      end
    end
    context "When the user is logged in through meurio" do
      let(:user) { Authorization.make!(provider: "meurio", uid: "01").user }
      it "should not return a picture url from facebook" do
        user.picture.should_not be_== "http://graph.facebook.com/01/picture?type=large"
      end
    end
    
  end

end
