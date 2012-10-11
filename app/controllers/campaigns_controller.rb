# coding: utf-8
class CampaignsController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:index, :create]
  before_filter :only => [:create] { params[:campaign][:user_id] = current_user.id }
  before_filter :only => [:show] { @poke = Poke.new }
  before_filter :only => [:show] { @answer = Answer.new }
  before_filter :only => [:index] { @highlight_campaign = Campaign.featured.last || Campaign.accepted.first }

  def create
    create! do |success, failure|
      success.html do 
        bitly = Bitly.new(ENV['BITLY_ID'], ENV['BITLY_SECRET'])
        resource.update_attribute :short_url, bitly.shorten(Rails.application.routes.url_helpers.campaign_url(resource.id)).short_url
        return redirect_to campaigns_path, :notice => "Aí! Recebemos a sua campanha. Em breve entraremos em contato para colocá-la no ar..."
      end
      failure.html { render :new }
    end
  end

  def accept
    Campaign.find(params[:campaign_id]).update_attribute :accepted_at, Time.now
    params[:id] = params[:campaign_id]
    show(:notice => "Está valendo, campanha no ar!")
  end

  def finish
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.update_attributes :finished_at => Time.now, :succeed => params[:succeed]
    redirect_to @campaign
  end

  def feature
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.featured_at = params[:featured] == "true" ? Time.now : nil 
    @campaign.save!
    redirect_to :back and return
  end

  def index
    if params[:user_id]
      render :user_index
    end
  end

  def unmoderated
    @campaigns = Campaign.unmoderated
  end

  protected
  def collection
    if params[:user_id]
      @campaigns ||= end_of_association_chain.where(:user_id => params[:user_id])
    else
      @campaigns ||= end_of_association_chain.accepted
    end
  end
end
