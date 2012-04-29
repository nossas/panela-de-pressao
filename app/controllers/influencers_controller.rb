class InfluencersController < InheritedResources::Base
  before_filter :only => [:index] { @influencer = Influencer.new }

  def create
    create! do |success, failure|
      success.html { redirect_to influencers_path, :notice => "#{@influencer.name} adicionado" }
      failure.html { render :index }
    end
  end
end
