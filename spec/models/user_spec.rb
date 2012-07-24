require 'spec_helper'

describe User do
  describe "associations" do
    it { should have_many :authorizations }
    it { should have_many :campaigns }
  end
  describe "validations" do
    it { should validate_presence_of :email }
    it { should validate_presence_of :name }
  end

  describe "#pic" do
    context "when the user uploaded a picture" do
      before { subject.stub_chain(:file, :large, :url).and_return("profile.jpg") }
      its(:pic){ should be_== "profile.jpg" }
    end
    context "when the user have a picture from Facebook" do
      before { subject.stub(:facebook_pic).and_return("facebook.jpg") }
      its(:pic){ should be_== "facebook.jpg" }
    end
    context "when the user have a picture from somewhere" do
      before { subject.stub(:picture).and_return("picture.jpg") }
      its(:pic){ should be_== "picture.jpg" }
    end
    context "when the user have no picture at all" do
      its(:pic){ should be_== "http://meurio.org.br/assets/avatar_blank.png" }
    end
  end

end
