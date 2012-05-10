require 'spec_helper'

describe ApplicationController do

  describe "#require_facebook_auth" do
    context "when I have the Facebook auth" do
      before { controller.stub(:current_user).and_return(mock_model(User, :facebook_authorization => mock_model(Authorization))) }
      it "should not redirect to /auth/facebook" do
        controller.should_not_receive(:redirect_to).with("/auth/facebook")
        subject.send("require_facebook_auth")
      end
    end
    context "when I don't have the Facebook auth" do
      before { controller.stub(:current_user).and_return(mock_model(User, :facebook_authorization => nil)) }
      it "should redirect to /auth/facebook" do
        controller.should_receive(:redirect_to).with("/auth/facebook")
        subject.send("require_facebook_auth")
      end
    end
  end

  describe "#require_twitter_auth" do
    context "when I have the Twitter auth" do
      before { controller.stub(:current_user).and_return(mock_model(User, :twitter_authorization => mock_model(Authorization))) }
      it "should not redirect to /auth/twitter" do
        controller.should_not_receive(:redirect_to).with("/auth/twitter")
        subject.send("require_twitter_auth")
      end
    end
    context "when I don't have the Twitter auth" do
      before { controller.stub(:current_user).and_return(mock_model(User, :twitter_authorization => nil)) }
      it "should redirect to /auth/twitter" do
        controller.should_receive(:redirect_to).with("/auth/twitter")
        subject.send("require_twitter_auth")
      end
    end
  end

end

