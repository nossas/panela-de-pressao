class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :signed_in?

  before_filter {|controller| session[:restore_url] = request.url if controller.controller_name != "sessions" }
  before_filter { session[:poke] = params[:poke].merge(:campaign_id => params[:campaign_id]) if current_user.nil? && !params[:poke].nil? }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to new_session_path, :alert => exception.message
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
end

