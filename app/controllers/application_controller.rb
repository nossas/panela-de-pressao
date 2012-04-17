class ApplicationController < ActionController::Base
  protect_from_forgery

  protected
  def render_404
    raise ActionController::RoutingError.new('Not Found')
  end
end

