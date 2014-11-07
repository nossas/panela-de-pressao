class Api::V1::InfluencersController < ApplicationController
  respond_to :json

  def search
    @documents = PgSearch.multisearch(params[:q])
  end
end
