require 'spec_helper'

describe Poke do
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

  describe "#update_influencers_poke_counter" do
    let(:target1){ stub_model(Target) }
    let(:target2){ stub_model(Target) }
    before { subject.stub_chain(:campaign, :targets).and_return([target1, target2]) }
    
    context "when it's an email poke" do
      before { subject.stub(:kind).and_return("email") }
      it "should call increase_pokes_by_email for all targets" do
        target1.should_receive(:increase_pokes_by_email)
        target2.should_receive(:increase_pokes_by_email)
        subject.send("update_targets")
      end
    end
  end
end
