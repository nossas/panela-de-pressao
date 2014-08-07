require 'spec_helper'

describe Poke do
  before do
    bitly = Bitly.new('bitly id', 'bitly key')
    bitly.stub_chain(:shorten, :short_url).and_return("http://localhost:3000/campaigns")
    Bitly.stub(:new).and_return(bitly)
  end

  describe "#twitter?" do
    context "when kind is other than twitter" do
      subject{ Poke.new(:kind => 'email').twitter? }
      it{ should be_false }
    end

    context "when kind is twitter" do
      subject{ Poke.new(:kind => 'twitter').twitter? }
      it{ should be_true }
    end
  end

  describe "#email?" do
    context "when kind is other than email" do
      subject{ Poke.new(:kind => 'twitter').email? }
      it{ should be_false }
    end

    context "when kind is email" do
      subject{ Poke.new(:kind => 'email').email? }
      it{ should be_true }
    end
  end

  describe "#first?" do
    context "when the user never poked this campaign" do
      before { subject.stub(:campaign_id).and_return(1) }
      before { subject.stub(:user_id).and_return(1) }
      before { Poke.stub(:where).with(:user_id => 1, :campaign_id => 1).and_return([subject]) }
      its(:first?){ should be_true }
    end

    context "when the user already poked this campaign" do
      before { subject.stub(:campaign_id).and_return(1) }
      before { subject.stub(:user_id).and_return(1) }
      before { Poke.stub(:where).with(:user_id => 1, :campaign_id => 1).and_return([stub_model(Poke), subject]) }
      its(:first?){ should be_false }
    end
  end

  describe "#sync_reward" do
    before do
      subject.stub(:campaign_id).and_return(1)
      subject.stub(:user_id).and_return(1)
      Poke.stub(:where).with(:user_id => 1, :campaign_id => 1).and_return([subject])
    end

    context "when the request returns 201" do
      before { HTTParty.stub(:post).and_return(Net::HTTPCreated.new('1.1', 201, 'OK')) }

      it "should update the rewarded flag to true" do
        expect(subject).to receive(:update_attribute).with(:rewarded, true)
        subject.sync_reward
      end
    end

    context "when the request doesn't returns 201" do
      before { HTTParty.stub(:post).and_return(Net::HTTPUnauthorized.new('1.1', 403, 'Unauthorized')) }

      it "should not update the rewarded flag to true" do
        expect(subject).not_to receive(:update_attribute).with(:rewarded, true)
        subject.sync_reward
      end
    end
  end

  describe "#valid_frequency?" do
    context "when there is no poke for the given user and campaign for today" do
      it "should return true" do
        Poke.valid_frequency?(1, 1).should be_true
      end
    end

    context "when there is at least one poke for the given user and campaign for today" do
      before { @poke = Poke.make! }
      it "should return false" do
        Poke.valid_frequency?(@poke.user_id, @poke.campaign_id).should be_false
      end
    end
  end

  describe "#frequency_validation" do
    let(:errors) { double('errors') }
    subject { stub_model(Poke, user_id: 1, campaign_id: 1, errors: errors) }

    context "when it's a valid frequency" do
      before { Poke.stub(:valid_frequency?).with(1, 1).and_return(true) }
      it "should not add an error into the created_at attribute" do
        errors.should_not receive(:add)
        subject.frequency_validation
      end
    end

    context "when it's not a valid frequency" do
      before { Poke.stub(:valid_frequency?).with(1, 1).and_return(false) }
      it "should add an error into the created_at attribute" do
        errors.should receive(:add)
        subject.frequency_validation
      end
    end
  end
end
