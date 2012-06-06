class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?

  before_filter { |controller| 
    if controller.controller_name != "sessions" && !request.xhr? && !(controller.controller_name == "campaigns" && controller.action_name == "index")
      session[:restore_url] = request.url 
    end
  }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to campaigns_path + "#login", :flash => {:login_alert => exception.message}
  end

  protected
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.id
  end

  def require_facebook_auth
    return redirect_to "/auth/facebook" unless current_user.facebook_authorization
  end

  def require_twitter_auth
    return redirect_to "/auth/twitter" unless current_user.twitter_authorization
  end
end

