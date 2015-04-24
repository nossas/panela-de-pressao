# coding: utf-8
class SessionsController < ApplicationController
  def create
    if @auth = Authorization.find_from_hash(auth_data)
      @auth.update_attributes(
        token: auth_data['credentials']['token'],
        secret: auth_data['credentials']['secret']
      )
    elsif auth_data['provider'] == 'twitter'
      user_hash = {
        email: session.delete('email'),
        first_name: session.delete('first_name'),
        last_name: session.delete('last_name'),
        organization_id: Campaign.find(session[:poke][:campaign_id]).organization_id
      }
      user = current_user ||
        User.create_with(user_hash).find_or_create_by(email: user_hash['email'])
      @auth = Authorization.create_from_hash(auth_data, user)
    else
      @auth = Authorization.create_from_hash(auth_data, current_user)
    end

    if session[:poke]
      redirect_to create_from_session_campaign_pokes_path(:campaign_id => session[:poke][:campaign_id], :user_id => @auth.user.id)
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
