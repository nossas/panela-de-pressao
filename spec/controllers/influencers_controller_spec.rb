require 'spec_helper'

describe InfluencersController do
  describe "GET show" do
    let(:influencer) { Influencer.new }

    before do
      Influencer.should_receive(:find).with("1").and_return(influencer)
    end

    context "when the influencer is archived" do
      before do
        influencer.stub!(:archived?).and_return(true)
      end

      context "and the user is logged in" do
        let(:user) { User.new }
        
        before do
          User.stub!(:find_by_id).and_return(user)
        end
        
        context "and can edit influencers" do
          before do
            user.admin = true
            get :show, id: 1
          end

          it { should respond_with(200) }
        end

        context "and cannot edit influencers" do
          before do
            get :show, id: 1
          end
          
          it { should redirect_to influencers_path }
        end
      end

      context "and the user is not logged in" do
        before do
          get :show, id: 1
        end
        
        it { should redirect_to influencers_path }
      end
    end

    context "when the influencer is not archived" do
      before do
        influencer.stub!(:archived?).and_return(false)

        get :show, id: 1
      end

      it { should respond_with(200) }
    end
  end
end
