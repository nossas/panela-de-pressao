# coding: utf-8
class SessionsController < ApplicationController
  def create
    if @auth = Authorization.find_from_hash(auth_data)
      @auth.update_attributes :token => auth_data['credentials']['token'], :secret => auth_data['credentials']['secret']
    else
      @auth = Authorization.create_from_hash(auth_data, current_user)
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

  protected
  def auth_data
    request.env['omniauth.auth']
  end
end
