# coding: utf-8
class CampaignsController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:index, :create]
  before_filter :only => [:create] { params[:campaign][:user_id] = current_user.id }
  before_filter :only => [:show] { @poke = Poke.new }
  before_filter :only => [:show] { @answer = Answer.new }
  before_filter :only => [:index] { @highlight_campaign = Campaign.featured.last || Campaign.accepted.first }

  def create
    @campaign = Campaign.new(params[:campaign])
    if params[:user_mobile_phone].nil? || current_user.update_attributes(:mobile_phone => params[:user_mobile_phone])
      create! do |success, failure|
        success.html { return redirect_to campaigns_path, :notice => "Aí! Recebemos a sua campanha. Em breve entraremos em contato para colocá-la no ar..." }
        failure.html { render :new }
      end
    else
      @campaign.errors[:user] << current_user.errors.full_messages.join(", ")
      render :new
    end
  end

  def update
    @campaign = Campaign.find(params[:id])
    if params[:user_mobile_phone].nil? || current_user.update_attributes(:mobile_phone => params[:user_mobile_phone])
      update!
    else
      @campaign.errors[:user] << current_user.errors.full_messages.join(", ")
      render :edit
    end
  end

  def accept
    Campaign.find(params[:campaign_id]).accept_now!
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
