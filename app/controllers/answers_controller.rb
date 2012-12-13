class AnswersController < ApplicationController
  load_and_authorize_resource
  inherit_resources
  belongs_to :campaign
  actions :create, :destroy

  def create
    create! { answers_campaign_path(@campaign) }
  end

  def destroy 
    destroy! { answers_campaign_path(@campaign) }
  end
end
