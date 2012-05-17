class PostsController < ApplicationController
  load_and_authorize_resource
  inherit_resources
  actions :create, :index, :destroy
  belongs_to :campaign

  def create
    create! do
      return index
    end
  end

  def index
    index! do
      return render :index, :layout => false
    end
  end

  def destroy
    destroy! do |format|
      return index
    end
  end
end
