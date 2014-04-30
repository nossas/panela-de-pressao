class UsersController < ApplicationController
  inherit_resources
  load_and_authorize_resource
  before_filter only: [:update] { return render nothing: true, status: :unauthorized unless can?(:update, @user) }
  has_scope :by_campaign_id
  autocomplete :user, :email

  def index
    authorize! :export, @current_user if params[:format] == "csv"
    @users = User.by_campaign_id(params[:by_campaign_id])
    respond_to do |format|
      format.csv { render :layout => false }
    end
  end
end
