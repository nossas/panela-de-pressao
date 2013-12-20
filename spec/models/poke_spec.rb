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

end
