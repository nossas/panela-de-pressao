class ErrorsController < ApplicationController
  def not_found
    render template: "errors/not_found", status: 404
  end
end
