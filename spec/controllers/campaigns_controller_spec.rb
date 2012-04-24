# coding: utf-8
require 'spec_helper'

describe CampaignsController do
  describe "POST create" do
    before { Campaign.any_instance.stub(:save) }
    before { post :create, :campaign => {} }
    it { should redirect_to campaigns_path }
    it { should set_the_flash.to "Aí! Recebemos a sua campanha. Em breve entraremos em contato para colocá-la no ar..." }
  end
end
