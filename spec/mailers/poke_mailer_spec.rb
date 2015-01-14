require "spec_helper"

describe PokeMailer do
  describe ".facebook_client_error" do
    before { @admin = User.make! admin: true }
    let(:target) { Target.make! }
    let(:poke) { Poke.make! campaign: target.campaign }
    subject { PokeMailer.facebook_client_error(target, poke) }

    its(:to) { should be_eql([@admin.email]) }
    its(:body) { should match(poke.user.name) }
    its(:body) { should match(poke.campaign.name) }
    its(:body) { should match(target.influencer.name) }
  end
end
