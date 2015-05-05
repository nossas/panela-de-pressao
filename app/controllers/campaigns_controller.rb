# coding: utf-8
class CampaignsController < InheritedResources::Base
  load_and_authorize_resource
  optional_belongs_to :organization
  optional_belongs_to :category
  optional_belongs_to :user

  skip_load_and_authorize_resource :only => [:create, :explore, :show]
  before_action(:only => [:new, :edit, :create, :update]) { @organizations = Organization.order(:city) }
  respond_to :html, :json, :js

  def show
    @campaign = Campaign.find_by_id(params[:id])
    return redirect_to not_found_path if @campaign.nil?

    @poke = Poke.new
    @answer = Answer.new
    @featured_update = Update.find_by_id(params[:update_id])
    @last_update = @campaign.updates.order(created_at: :desc).first
    @campaign_users = CampaignOwner.where(campaign_id: @campaign.id).map{|co| co.user}
    @campaign_pokes = Poke.where(campaign: @campaign).includes(:user).order(created_at: :desc).limit(5)
    @pokers_count = Poke.where(campaign: @campaign).distinct.count(:user_id)
  end

  def create
    user = current_user ||
      User.find_by(email: params[:campaign][:user][:email]) ||
      User.find(User.create(params[:campaign][:user].merge(
        ip: request.ip,
        organization_id: params[:campaign][:organization_id],
        password: SecureRandom.hex
      )).id)

    user.update_attributes(phone: params[:user_phone]) if params[:user_phone].present?

    @campaign = Campaign.new(params[:campaign].merge(user_id: user.id))
    if @campaign.save
      return redirect_to @campaign
    else
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
        @popular = Campaign.popular.unarchived.includes(:user).limit(4).shuffle
        @featured = Campaign.featured.first
        @successful_campaigns = Campaign.successful.includes(:user).order("random()").limit(4)
        @moderator_organization = Organization.random_moderator

        if @moderator_organization
          @moderated_campaigns = @moderator_organization.
            moderations.where("finished_at IS NULL").includes(:user).limit(3)
        end

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

  def explore
    @campaigns = Campaign.moderated_first.order(created_at: :desc).unarchived

    @campaigns = @campaigns.successful if params[:successful]
    @campaigns = @campaigns.unfinished if params[:unfinished]

    @campaigns = @campaigns.where(organization_id: params[:organizations]) if params[:organizations].present?
    @campaigns = @campaigns.where(category_id: params[:categories]) if params[:categories].present?

    @campaigns_count = @campaigns.count
    @campaigns = @campaigns.page(params[:page]).per(9)

    respond_with @campaigns
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
