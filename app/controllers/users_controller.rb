class UsersController < ApplicationController
  inherit_resources
  load_and_authorize_resource
  before_filter only: [:update] { return render nothing: true, status: :unauthorized unless can?(:update, @user) }
  has_scope :by_campaign_id
  autocomplete :user, :name

  def index
    authorize! :export, @current_user if params[:format] == "csv"
    respond_to do |format|
      format.csv { render :layout => false }
    end
  end

  def unsubscribe
    user = User.find(params[:user_id])
    if user.token == params[:token]
      user.update_attributes :subscriber => false
    end
  end
end
