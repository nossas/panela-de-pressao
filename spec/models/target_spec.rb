require 'spec_helper'

describe Target do
  describe "#increase_pokes_by_twitter" do
    context "when there is a twitter" do
      before { subject.stub_chain(:influencer, :twitter).and_return "eduardopaes" }
      it "should update email pokes" do
        subject.should_receive(:update_attributes).with({:pokes_by_twitter => 1})
        subject.increase_pokes_by_twitter
      end
    end

    context "when there isn't a twitter" do
      before { subject.stub_chain(:influencer, :twitter).and_return "" }
      it "should not update email pokes" do
        subject.should_not_receive(:update_attributes)
        subject.increase_pokes_by_twitter
      end
    end
  end

  describe "#increase_pokes_by_email" do
    context "when there is an email" do
      before { subject.stub_chain(:influencer, :email).and_return "eduardopaes@meurio.org.br" }
      it "should update email pokes" do
        subject.should_receive(:update_attributes).with({:pokes_by_email => 1})
        subject.increase_pokes_by_email
      end
    end

    context "when there isn't an email" do
      before { subject.stub_chain(:influencer, :email).and_return "" }
      it "should not update email pokes" do
        subject.should_not_receive(:update_attributes)
        subject.increase_pokes_by_email
      end
    end
  end
end
