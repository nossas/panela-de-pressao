class SessionsController < ApplicationController
  #skip_authorization_check

  def create
    auth = request.env['omniauth.auth']
    unless @auth = Authorization.find_from_hash(auth)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth, current_user)
    end

    # Log the authorizing user in.
    self.current_user = @auth.user
    redirect_to questions_path
  end

  def destroy
    reset_session
    redirect_to questions_path
  end
end
