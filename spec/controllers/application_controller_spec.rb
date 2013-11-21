require 'spec_helper'

describe ApplicationController do

  describe "#require_facebook_auth" do
    it "should redirect to /auth/facebook" do
      controller.should_receive(:redirect_to).with("/auth/facebook")
      subject.send("require_facebook_auth")
    end
  end

  describe "#require_twitter_auth" do
    it "should redirect to /auth/twitter" do
      controller.should_receive(:redirect_to).with("/auth/twitter")
      subject.send("require_twitter_auth")
    end
  end

end

