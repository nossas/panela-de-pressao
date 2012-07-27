class UsersController < ApplicationController
  inherit_resources
  load_and_authorize_resource
  before_filter only: [:update] { return render nothing: true, status: :unauthorized unless current_user and current_user == @user }

  def index
    authorize! :export, @current_user if params[:format] == "csv"
    respond_to do |format|
      format.csv { render :layout => false }
    end
  end
end
