require 'spec_helper'

describe Influencer do
  describe "associations" do
    it { should have_many :targets }
    it { should have_many :campaigns }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :role }
  end

	describe "#update_facebook" do
		subject { stub_model(Influencer, :facebook_url => "http://www.facebook.com/eduardopaesRJ", :facebook_id => "165276720205822") }
		before do
  			@public_page = double(:get_object => {
					"link" => "http://www.facebook.com/coca-cola",
					"id" => "40796308305",
					"can_post" => true
				})
  			@private_page = double(:get_object => {
					"link" => "http://www.facebook.com/coca-cola",
					"id" => "40796308305",
					"can_post" => false
				})
		end
		context "when the url represents a Facebook public page" do
			it "should update the facebook_id to the new one" do
				Koala::Facebook::API.stub(:new).and_return @public_page
				subject.update_facebook("http://www.facebook.com/coca-cola")
				subject.facebook_url.should be_== "http://www.facebook.com/coca-cola"
				subject.facebook_id.should be_== "40796308305"
			end
		end
		context "when the url doesn't represents a Facebook public page" do
			before { Koala::Facebook::API.stub(:new).and_return @private_page }
			it "should not update the the facebook_id" do
				subject.update_facebook("http://www.facebook.com/coca-cola")
				subject.facebook_url.should be_== "http://www.facebook.com/eduardopaesRJ"
				subject.facebook_id.should be_== "165276720205822"
			end
			it "should send an email warning who tried to change it" do
				User.stub(:find).with(1).and_return(stub_model(User, :email => "test@paneladepressao.org.br"))
				subject.update_facebook("http://www.facebook.com/coca-cola", :by => 1)
				ActionMailer::Base.deliveries.should_not be_empty
			end
		end
	end

	describe "#archived=" do
	  let(:influencer) { Influencer.new }

    context "when archived is true" do
      subject { influencer.archived = true }

      context "and archived_at is null" do
        it { expect { subject }.to change(influencer, :archived_at) }
      end

      context "and the archived_at is not null" do
        before do
          influencer.archived_at = Time.now
        end

        it { expect { subject }.to_not change(influencer, :archived_at) }
      end
    end

    context "when archived is false" do
      subject { influencer.archived = false }
      
      before do
        influencer.archived_at = Time.now
      end

      it { expect { subject }.to change(influencer, :archived_at) }
    end
  end

  describe "#archived" do
	  let(:influencer) { Influencer.new }
    subject { influencer.archived }

    context "when archived_at is null" do
      it { should be_false } 
    end

    context "when archived_at is not null" do
      before do
        influencer.archived_at = Time.now
      end
      it { should be_true }
    end
  end

  describe ".available" do
    let(:influencer1) { Influencer.make! }
    let(:influencer2) { Influencer.make!(archived_at: Time.now) }

    subject { Influencer.available }
    it { should include(influencer1) }
    it { should_not include(influencer2) }
  end
end
