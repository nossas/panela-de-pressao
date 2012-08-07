class AnswersController < InheritedResources::Base
  belongs_to :campaign

  def create
    create! do |success, failure|
      success.html { redirect_to answers_campaign_path(@campaign) }
    end
  end
end
