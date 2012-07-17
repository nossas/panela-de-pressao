class UsersController < ApplicationController
  inherit_resources
  load_and_authorize_resource
  before_filter only: [:update] { return render nothing: true, status: :unauthorized unless current_user and current_user == @user }
end
