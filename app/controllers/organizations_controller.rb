# coding: utf-8
class OrganizationsController < InheritedResources::Base
  load_and_authorize_resource
  skip_load_and_authorize_resource :only => [:index, :show]
  before_filter only: [:create] { @organization.owner = current_user }

  def create
    create! do |success, failure|
      success.html { redirect_to root_path, :notice => "A organização #{@organization.name} foi criada!" }
    end
  end
end
