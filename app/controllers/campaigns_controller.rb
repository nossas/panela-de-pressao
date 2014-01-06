# coding: utf-8
class CampaignsController < InheritedResources::Base
  load_and_authorize_resource
  has_scope :popular,     only: [:explore]
  has_scope :successful,  only: [:explore] 
  optional_belongs_to :category
  
  custom_actions collection: :explore
  
  skip_load_and_authorize_resource :only => [:create, :explore]

  before_filter :only => [:create] { params[:campaign][:user_id] = current_user.id }
  before_filter :only => [:show] { @poke = Poke.new }
  before_filter :only => [:show] { @answer = Answer.new }
  before_filter :only => [:show] { @featured_update = Update.find_by_id(params[:update_id]) }
  before_filter :only => [:show] { @last_update = @campaign.updates.order("created_at DESC").first }
  before_filter :only => [:show] { @campaign_users = CampaignOwner.where(campaign_id: @campaign.id).map{|co| co.user} }
  before_filter :only => [:show] { @campaign_pokes = Poke.where(campaign_id: @campaign.id).includes(:user).limit(5) }
  before_filter :only => [:index] { @popular = Campaign.popular.limit(4).shuffle }
  before_filter :only => [:index] { @featured = Campaign.featured || Campaign.moderated.limit(5) }
  before_filter :only => [:index] { @moderator = User.where("id IN (?)", Campaign.all.map{|c| c.moderator_id}.compact.uniq).order("random()").first }
  before_filter :only => [:index] { @successful_campaigns = Campaign.successful.order("random()").limit(4) }

  def create
    @campaign = Campaign.new(params[:campaign])
    if params[:user_phone].nil? || current_user.update_attributes(:phone => params[:user_phone])
      create! do |success, failure|
        success.html { return redirect_to @campaign }
        failure.html { render :new }
      end
    else
      @campaign.errors[:user] << current_user.errors.full_messages.join(", ")
      render :new
    end
  end

  def update
    @campaign = Campaign.find(params[:id])
    if params[:user_phone].nil? || current_user.update_attributes(:phone => params[:user_phone])
      update!
    else
      @campaign.errors[:user] << current_user.errors.full_messages.join(", ")
      render :edit
    end
  end

  def finish
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.update_attributes finished_at: Time.now, succeed: params[:succeed]
    redirect_to @campaign
  end

  def feature
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.update_attribute :featured_at, params[:featured] == "true" ? Time.now : nil
    redirect_to @campaign
  end

  def index
    respond_to do |format|
      format.html do
        if params[:user_id]
          render :user_index
        elsif parent?
          render :explore
        else
          render :index
        end
      end
      format.json { render :json => collection.to_json }
    end
  end

  def unmoderated
    @campaigns = Campaign.unmoderated.unarchived.order("created_at DESC")
  end

  def moderate
    @campaign = Campaign.find(params[:campaign_id])
    @campaign.update_attributes :moderator_id => current_user.id
    redirect_to @campaign
  end

  def archive
    campaign = Campaign.find(params[:campaign_id])
    campaign.update_attributes :archived_at => Time.now
    redirect_to campaign
  end

  def reported
    @campaigns = Campaign.reported
  end

  protected
  def collection
    if params[:user_id]
      @campaigns ||= end_of_association_chain.where(:user_id => params[:user_id])
    else
      @campaigns ||= end_of_association_chain.unarchived.moderated + end_of_association_chain.unarchived.unmoderated
    end
  end
end
