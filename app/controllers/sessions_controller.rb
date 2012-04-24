class SessionsController < ApplicationController
  #skip_authorization_check

  def create
    unless @auth = Authorization.find_from_hash(auth_data)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth_data, current_user)
    end

    # Log the authorizing user in.
    self.current_user = @auth.user
    redirect_to session[:restore_url] || root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  def new
  end

  protected
  def auth_data
    request.env['omniauth.auth']
  end
end
