class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?, :is_current_user?
  before_filter { |controller| session[:restore_url] = request.url if controller.controller_name != "sessions" && !request.xhr? }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to ENV["MEURIO_ACCOUNTS_URL"], redirect_url: request.host
  end

  protected
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def current_user
    @current_user ||= User.find_by_id(session[:ssi_user_id])
  end

  def is_current_user?(user)
    current_user == user
  end

  def signed_in?
    !!current_user
  end

  def require_facebook_auth
    return redirect_to "/auth/facebook" unless current_user.facebook_authorization
  end

  def require_twitter_auth
    return redirect_to "/auth/twitter" unless current_user.twitter_authorization
  end
  
  private
  def current_ability
    @current_ability ||= Ability.new(current_user, request)
  end
end
