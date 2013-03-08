#coding: utf-8

require 'spec_helper'

describe UsersController do
  before do
    @user = Authorization.make!.user
  end
  describe "#show" do
    before do
      get :show, id: @user.id
    end
    its(:status) { should == 200 }
  end


  describe "#update" do
    context "When the current user is the user being updated" do
      before do
        controller.stub(:current_user).and_return(@user)
        put :update, id: @user.id, user: { about_me: "Updated oh oh oh" }
      end
      its(:status) { should == 302 }
    context "When the current user is not the user being updated" do
      before do
        controller.stub!(:current_user).and_return(false)
        put :update, id: @user.id, user: { about_me: "Trying to update something that isn't mine hohoho" }
      end
      its(:status) { should == 302 }
    end
    end
  end

end
