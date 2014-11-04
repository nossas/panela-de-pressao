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
		subject { Influencer.make! :facebook_url => "http://www.facebook.com/eduardopaesRJ", :facebook_id => "165276720205822" }
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
				allow(User).to receive(:find).with(1).and_return(User.make! :email => "test@paneladepressao.org.br")
				subject.update_facebook("http://www.facebook.com/coca-cola", :by => 1)
				ActionMailer::Base.deliveries.should_not be_empty
			end
		end
	end

	describe "#archive" do
	  subject { Influencer.make! }
    before do
      @time = Time.now
      allow(Time).to receive(:now).and_return(@time)
    end

    context "when it is not archived" do
      before { subject.archived_at = nil }

      it "should archive the campaign" do
        expect{ subject.archive }.to change{ subject.archived_at }.from(nil).to(@time)
      end
    end

    context "when it is archived" do
      before { subject.archived_at = Time.now }

      it "should unarchive the campaign" do
        expect{ subject.archive }.to change{ subject.archived_at }.from(@time).to(nil)
      end
    end
  end

  describe "#archived?" do
    subject { Influencer.make! }

    context "when it is not archived" do
      before { subject.archived_at = nil }

      it "should be false" do
        expect(subject.archived?).to be_falsey
      end
    end

    context "when it is archived" do
      before { subject.archived_at = Time.now }

      it "should unarchive the campaign" do
        expect(subject.archive).to be_truthy
      end
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
