require 'spec_helper'

describe PostsController do
  subject{ response }
  let(:campaign){ Campaign.make! }
  before do
    controller.stub(:current_user).and_return(campaign.user)
  end

  describe "GET index" do
    before do
      get :index, :campaign_id => campaign.id
    end
    its(:status){ should == 200 }
  end

  describe "POST create" do
    before do
      post :create, :campaign_id => campaign.id, :post => {:content => 'this is a test'}
    end
  
    it("@post should not be nil"){ assigns(:post).should_not be_nil }
    it("@posts should not be nil"){ assigns(:posts).should_not be_nil }
    its(:status){ should == 200 }
  end

  describe "DELETE destroy" do
    before do
      @post = Post.make! :campaign => campaign
      delete :destroy, :campaign_id => campaign.id, :id => @post.id
    end
  
    it{ should redirect_to campaign_posts_path(:campaign_id => campaign.id) }
  end

end
