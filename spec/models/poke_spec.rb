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


end
