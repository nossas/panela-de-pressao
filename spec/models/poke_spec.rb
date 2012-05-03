require 'spec_helper'

describe Poke do
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
