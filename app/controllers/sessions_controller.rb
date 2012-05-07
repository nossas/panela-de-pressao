# coding: utf-8
class SessionsController < ApplicationController
  def create
    unless @auth = Authorization.find_from_hash(auth_data)
      # Create a new user or add an auth to existing user, depending on
      # whether there is already a user signed in.
      @auth = Authorization.create_from_hash(auth_data, current_user)
    end

    # Log the authorizing user in.
    self.current_user = @auth.user

    # Authorize twitter
    if twitter_auth = @auth.user.authorizations.where(:provider => 'twitter').first
      Twitter.configure do |c|
        c.oauth_token = twitter_auth.token
        c.oauth_token_secret = twitter_auth.secret
      end
    end

    if session[:poke]
      redirect_to create_from_session_campaign_pokes_path(:campaign_id => session[:poke][:campaign_id])
    else
      redirect_to session[:restore_url] || root_path
    end
  end

  def destroy
    reset_session
    redirect_to session[:restore_url] || root_path
  end

  def new
  end

  protected
  def auth_data
    request.env['omniauth.auth']
  end
end
