class CampaignsController < InheritedResources::Base
  protected
  def collection
    @campaigns ||= end_of_association_chain.accepted
  end
end
