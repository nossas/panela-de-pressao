require 'spec_helper'

describe Target do
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

  describe "#increase_pokes_by_facebook" do
    context "when there is facebook" do
      before { subject.stub_chain(:influencer, :facebook).and_return "http://www.facebook.com/eduardopaesRJ" }
      it "should update facebook pokes" do
        subject.should_receive(:update_attributes).with({:pokes_by_facebook => 1})
        subject.increase_pokes_by_facebook
      end
    end

    context "when there isn't facebook" do
      before { subject.stub_chain(:influencer, :facebook).and_return "" }
      it "should not update facebook pokes" do
        subject.should_not_receive(:update_attributes)
        subject.increase_pokes_by_facebook
      end
    end
  end
end
