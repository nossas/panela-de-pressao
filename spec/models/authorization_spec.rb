require 'spec_helper'

describe Authorization do
  before do
    @user = User.make!
  end

  describe "Validations/Associations" do
    it { should belong_to :user }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :uid }
    it { should validate_presence_of :provider }
  end


  describe "#find_from_hash" do
    it "Should find the provider and UID when it's already in database" do

      mr = MEURIO_HASH
      authorization = Authorization.make! :provider => mr['provider'], :uid => mr['uid'], :user => @user
      Authorization.find_from_hash(mr).should_not be_nil
    end

    it "Should return nil if the provider/uid isn't in the DB" do
      Authorization.destroy_all
      Authorization.find_from_hash(MEURIO_HASH).should == nil
    end
  end


  describe "#create_from_hash" do
    context "When an user exists, return an existent" do
      mr = MEURIO_HASH
      subject { Authorization.create_from_hash(mr, @user) }
      its(:uid) { should == mr['uid'] }
      its(:provider) { should == mr['provider'] }
      its(:user) { should == @user }
      its(:token) { should == mr['credentials']['token'] }
      its(:secret) { should == mr['credentials']['secret'] }
    end
    context "When the user doesn't exists, create one" do
      mr = MEURIO_HASH
      subject { Authorization.create_from_hash(mr) }
      its(:uid) { should == mr['uid'] }
      its(:provider) { should == mr['provider'] }
      its(:user) { should_not == nil }
      its(:token) { should == mr['credentials']['token'] }
      its(:secret) { should == mr['credentials']['secret'] }
    end
  end
end
